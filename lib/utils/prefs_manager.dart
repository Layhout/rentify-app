import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Exceptions ──────────────────────────────────────────────────────────────

sealed class PrefsException implements Exception {
  const PrefsException(this.message);
  final String message;
  @override
  String toString() => '$runtimeType: $message';
}

final class PrefsNotInitializedException extends PrefsException {
  const PrefsNotInitializedException()
    : super('PrefsManager has not been initialized. Call PrefsManager.init() first.');
}

final class PrefsTypeMismatchException extends PrefsException {
  const PrefsTypeMismatchException(String key, Type expected, Type actual)
    : super('Type mismatch for key "$key": expected $expected, got $actual.');
}

final class PrefsSerializationException extends PrefsException {
  const PrefsSerializationException(String key, Object cause)
    : super('Failed to serialize/deserialize value for key "$key": $cause');
}

// ─── Change event ────────────────────────────────────────────────────────────

/// Emitted on the [PrefsManager.changes] stream after every write or removal.
final class PrefsChangeEvent<T> {
  const PrefsChangeEvent({required this.key, required this.oldValue, required this.newValue});

  final String key;
  final T? oldValue;
  final T? newValue;

  bool get wasRemoved => newValue == null;
  bool get wasAdded => oldValue == null && newValue != null;

  @override
  String toString() => 'PrefsChangeEvent(key: $key, old: $oldValue, new: $newValue)';
}

// ─── Core manager ────────────────────────────────────────────────────────────

/// A singleton wrapper around [SharedPreferences] with:
///   • Null-safe typed getters / setters
///   • JSON object & list serialization
///   • Namespaced key grouping
///   • Reactive [changes] stream
///   • Bulk operations (getAll, removeAll, migrate)
///   • In-memory cache for zero-latency reads
///
/// ```dart
/// await PrefsManager.init();
///
/// await PrefsManager.instance.setString('username', 'alice');
/// final name = PrefsManager.instance.getString('username'); // 'alice'
/// ```
final class PrefsManager {
  PrefsManager._();

  static PrefsManager? _instance;
  static SharedPreferences? _prefs;
  final _cache = <String, Object?>{};
  final _changesController = StreamController<PrefsChangeEvent<dynamic>>.broadcast();

  // ── Singleton lifecycle ──────────────────────────────────────────────────

  /// Must be called once before using [instance], typically in `main()`.
  static Future<PrefsManager> init() async {
    if (_instance != null) return _instance!;
    _prefs = await SharedPreferences.getInstance();
    _instance = PrefsManager._();
    _instance!._seedCache();
    return _instance!;
  }

  /// The singleton instance. Throws [PrefsNotInitializedException] if
  /// [init] has not been called.
  static PrefsManager get instance {
    if (_instance == null) throw const PrefsNotInitializedException();
    return _instance!;
  }

  /// Reloads values from disk (useful after app resume on some platforms).
  Future<void> reload() async {
    await _prefs!.reload();
    _seedCache();
  }

  void _seedCache() {
    _cache.clear();
    for (final key in _prefs!.getKeys()) {
      _cache[key] = _prefs!.get(key);
    }
  }

  // ── Reactive stream ──────────────────────────────────────────────────────

  /// Emits a [PrefsChangeEvent] after every successful write or removal.
  Stream<PrefsChangeEvent<dynamic>> get changes => _changesController.stream;

  /// Filters [changes] to a specific key.
  Stream<PrefsChangeEvent<T>> changesFor<T>(String key) =>
      changes.where((e) => e.key == key).cast<PrefsChangeEvent<T>>();

  void _emit<T>(String key, T? oldValue, T? newValue) {
    _changesController.add(PrefsChangeEvent<T>(key: key, oldValue: oldValue, newValue: newValue));
  }

  // ── Primitive getters / setters ──────────────────────────────────────────

  String? getString(String key) => _get<String>(key);
  Future<bool> setString(String key, String value) => _set(key, value);

  int? getInt(String key) => _get<int>(key);
  Future<bool> setInt(String key, int value) => _set(key, value);

  double? getDouble(String key) => _get<double>(key);
  Future<bool> setDouble(String key, double value) => _set(key, value);

  bool? getBool(String key) => _get<bool>(key);
  Future<bool> setBool(String key, bool value) => _set(key, value);

  List<String>? getStringList(String key) => _get<List<String>>(key);
  Future<bool> setStringList(String key, List<String> value) => _set(key, value);

  // ── Typed getters with defaults ──────────────────────────────────────────

  String getStringOrDefault(String key, String defaultValue) => getString(key) ?? defaultValue;

  int getIntOrDefault(String key, int defaultValue) => getInt(key) ?? defaultValue;

  double getDoubleOrDefault(String key, double defaultValue) => getDouble(key) ?? defaultValue;

  bool getBoolOrDefault(String key, {required bool defaultValue}) => getBool(key) ?? defaultValue;

  List<String> getStringListOrDefault(String key, {List<String> defaultValue = const []}) =>
      getStringList(key) ?? defaultValue;

  // ── JSON object serialization ────────────────────────────────────────────

  /// Stores [value] as a JSON-encoded string under [key].
  Future<bool> setObject<T>(String key, T value) {
    try {
      final json = jsonEncode(value);
      return setString(key, json);
    } catch (e) {
      throw PrefsSerializationException(key, e);
    }
  }

  /// Retrieves the JSON-encoded value for [key] and decodes it with [fromJson].
  ///
  /// Returns `null` if the key does not exist.
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final raw = getString(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw PrefsTypeMismatchException(key, Map<String, dynamic>, decoded.runtimeType);
      }
      return fromJson(decoded);
    } catch (e) {
      throw PrefsSerializationException(key, e);
    }
  }

  /// Stores a list of objects as a JSON-encoded string.
  Future<bool> setObjectList<T>(String key, List<T> values) {
    try {
      final json = jsonEncode(values);
      return setString(key, json);
    } catch (e) {
      throw PrefsSerializationException(key, e);
    }
  }

  /// Retrieves a list of objects stored as JSON.
  List<T>? getObjectList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final raw = getString(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw PrefsTypeMismatchException(key, List, decoded.runtimeType);
      }
      return decoded.cast<Map<String, dynamic>>().map(fromJson).toList();
    } catch (e) {
      throw PrefsSerializationException(key, e);
    }
  }

  // ── Enum helpers ─────────────────────────────────────────────────────────

  /// Stores an enum value by its [name].
  Future<bool> setEnum<T extends Enum>(String key, T value) => setString(key, value.name);

  /// Retrieves an enum value by matching stored name against [values].
  ///
  /// ```dart
  /// prefs.getEnum('theme', ThemeMode.values);
  /// ```
  T? getEnum<T extends Enum>(String key, List<T> values) {
    final name = getString(key);
    if (name == null) return null;
    try {
      return values.firstWhere((e) => e.name == name);
    } catch (_) {
      return null;
    }
  }

  // ── Existence & removal ───────────────────────────────────────────────────

  bool containsKey(String key) => _cache.containsKey(key);

  /// Removes a single key. Returns `true` on success.
  Future<bool> remove(String key) async {
    final old = _cache[key];
    final success = await _prefs!.remove(key);
    if (success) {
      _cache.remove(key);
      _emit(key, old, null);
    }
    return success;
  }

  /// Removes all keys that match [predicate].
  Future<void> removeWhere(bool Function(String key) predicate) async {
    final targets = _cache.keys.where(predicate).toList();
    for (final key in targets) {
      await remove(key);
    }
  }

  /// Removes all stored values. Use with caution.
  Future<bool> clear() async {
    final snapshot = Map<String, Object?>.from(_cache);
    final success = await _prefs!.clear();
    if (success) {
      _cache.clear();
      for (final entry in snapshot.entries) {
        _emit(entry.key, entry.value, null);
      }
    }
    return success;
  }

  // ── Bulk reads ────────────────────────────────────────────────────────────

  /// All stored keys.
  Set<String> get keys => Set.unmodifiable(_cache.keys);

  /// All stored key-value pairs (raw, as stored).
  Map<String, Object?> getAll() => Map.unmodifiable(_cache);

  /// All pairs whose keys start with [prefix].
  Map<String, Object?> getAllWithPrefix(String prefix) =>
      Map.fromEntries(_cache.entries.where((e) => e.key.startsWith(prefix)));

  // ── Migration helpers ─────────────────────────────────────────────────────

  /// Renames [oldKey] to [newKey], preserving the stored value.
  /// No-op if [oldKey] does not exist.
  Future<void> migrate(String oldKey, String newKey) async {
    if (!containsKey(oldKey)) return;
    final value = _prefs!.get(oldKey);
    if (value != null) {
      await _writeRaw(newKey, value);
      await remove(oldKey);
    }
  }

  // ── Namespaced access ─────────────────────────────────────────────────────

  /// Returns a [NamespacedPrefs] that automatically prefixes every key
  /// with `"<namespace>."`.
  ///
  /// ```dart
  /// final userPrefs = prefs.namespace('user');
  /// await userPrefs.setString('name', 'Alice'); // stored as "user.name"
  /// ```
  NamespacedPrefs namespace(String namespace) => NamespacedPrefs._(namespace, this);

  // ── Internal helpers ──────────────────────────────────────────────────────

  T? _get<T>(String key) {
    final cached = _cache[key];
    if (cached == null) return null;
    if (cached is T) return cached as T;
    throw PrefsTypeMismatchException(key, T, cached.runtimeType);
  }

  Future<bool> _set<T extends Object>(String key, T value) async {
    final old = _cache[key];
    final success = await _writeRaw(key, value);
    if (success) {
      _cache[key] = value;
      _emit<T>(key, old as T?, value);
    }
    return success;
  }

  Future<bool> _writeRaw(String key, Object value) => switch (value) {
    final String v => _prefs!.setString(key, v),
    final int v => _prefs!.setInt(key, v),
    final double v => _prefs!.setDouble(key, v),
    final bool v => _prefs!.setBool(key, v),
    final List<String> v => _prefs!.setStringList(key, v),
    _ => throw PrefsTypeMismatchException(key, Object, value.runtimeType),
  };

  /// Disposes the change stream. Call in tests or if you need cleanup.
  Future<void> dispose() async {
    await _changesController.close();
    _instance = null;
    _prefs = null;
  }
}

// ─── Namespaced wrapper ───────────────────────────────────────────────────────

/// Wraps [PrefsManager] so every key is automatically prefixed.
///
/// ```dart
/// final auth = prefs.namespace('auth');
/// await auth.setString('token', 'abc');    // → 'auth.token'
/// await auth.setBool('rememberMe', true);  // → 'auth.rememberMe'
/// auth.clearNamespace();                   // removes all 'auth.*' keys
/// ```
final class NamespacedPrefs {
  NamespacedPrefs._(this._namespace, this._manager);

  final String _namespace;
  final PrefsManager _manager;

  String _k(String key) => '$_namespace.$key';

  // ── Primitives ────────────────────────────────────────────────────────────

  String? getString(String key) => _manager.getString(_k(key));
  Future<bool> setString(String key, String value) => _manager.setString(_k(key), value);

  int? getInt(String key) => _manager.getInt(_k(key));
  Future<bool> setInt(String key, int value) => _manager.setInt(_k(key), value);

  double? getDouble(String key) => _manager.getDouble(_k(key));
  Future<bool> setDouble(String key, double value) => _manager.setDouble(_k(key), value);

  bool? getBool(String key) => _manager.getBool(_k(key));
  Future<bool> setBool(String key, bool value) => _manager.setBool(_k(key), value);

  List<String>? getStringList(String key) => _manager.getStringList(_k(key));
  Future<bool> setStringList(String key, List<String> value) => _manager.setStringList(_k(key), value);

  // ── Typed with defaults ──────────────────────────────────────────────────

  String getStringOrDefault(String key, String d) => _manager.getStringOrDefault(_k(key), d);
  int getIntOrDefault(String key, int d) => _manager.getIntOrDefault(_k(key), d);
  double getDoubleOrDefault(String key, double d) => _manager.getDoubleOrDefault(_k(key), d);
  bool getBoolOrDefault(String key, {required bool defaultValue}) =>
      _manager.getBoolOrDefault(_k(key), defaultValue: defaultValue);

  // ── JSON ─────────────────────────────────────────────────────────────────

  Future<bool> setObject<T>(String key, T value) => _manager.setObject(_k(key), value);

  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) => _manager.getObject(_k(key), fromJson);

  Future<bool> setObjectList<T>(String key, List<T> values) => _manager.setObjectList(_k(key), values);

  List<T>? getObjectList<T>(String key, T Function(Map<String, dynamic>) fromJson) =>
      _manager.getObjectList(_k(key), fromJson);

  // ── Enum ─────────────────────────────────────────────────────────────────

  Future<bool> setEnum<T extends Enum>(String key, T value) => _manager.setEnum(_k(key), value);
  T? getEnum<T extends Enum>(String key, List<T> values) => _manager.getEnum(_k(key), values);

  // ── Existence & removal ───────────────────────────────────────────────────

  bool containsKey(String key) => _manager.containsKey(_k(key));
  Future<bool> remove(String key) => _manager.remove(_k(key));

  /// Removes all keys under this namespace.
  Future<void> clearNamespace() => _manager.removeWhere((k) => k.startsWith('$_namespace.'));

  // ── Reactive ─────────────────────────────────────────────────────────────

  Stream<PrefsChangeEvent<T>> changesFor<T>(String key) => _manager.changesFor<T>(_k(key));

  Stream<PrefsChangeEvent<dynamic>> get allChanges => _manager.changes.where((e) => e.key.startsWith('$_namespace.'));
}

// ─── Strongly-typed key abstraction ─────────────────────────────────────────

/// A type-safe key that carries its own default value.
///
/// ```dart
/// const kTheme = PrefsKey<String>('app.theme', defaultValue: 'system');
///
/// await kTheme.set('dark');
/// final theme = kTheme.get(); // 'dark'
/// ```
final class PrefsKey<T> {
  const PrefsKey(this.key, {this.defaultValue});

  final String key;
  final T? defaultValue;

  T? get() {
    final prefs = PrefsManager.instance;
    return switch (T) {
          const (String) => prefs.getString(key) as T?,
          const (int) => prefs.getInt(key) as T?,
          const (double) => prefs.getDouble(key) as T?,
          const (bool) => prefs.getBool(key) as T?,
          _ => throw PrefsTypeMismatchException(key, T, T),
        } ??
        defaultValue;
  }

  Future<bool> set(T value) {
    final prefs = PrefsManager.instance;
    return switch (value) {
      final String v => prefs.setString(key, v),
      final int v => prefs.setInt(key, v),
      final double v => prefs.setDouble(key, v),
      final bool v => prefs.setBool(key, v),
      _ => throw PrefsTypeMismatchException(key, T, value.runtimeType),
    };
  }

  Future<bool> remove() => PrefsManager.instance.remove(key);
  bool exists() => PrefsManager.instance.containsKey(key);

  Stream<PrefsChangeEvent<T>> get changes => PrefsManager.instance.changesFor<T>(key);
}
