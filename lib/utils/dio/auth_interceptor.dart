import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rentify_app/utils/prefs_manager.dart';
import 'api_exception.dart';

/// Header key used to skip auth (e.g. login, refresh endpoints).
const _kSkipAuth = 'X-Skip-Auth';

/// Marker added to retried requests so we don't retry twice.
const _kRetried = 'X-Retried';

/// Called when token refresh succeeds – useful for updating UI state.
typedef OnTokenRefreshed = void Function(String newAccessToken, String newRefreshToken);

/// Called when refresh fails and the user must log in again.
typedef OnSessionExpired = void Function();

/// Refresh token response model.
final class TokenPair {
  const TokenPair({required this.accessToken, required this.refreshToken});
  final String accessToken;
  final String refreshToken;
}

/// Signature the caller must provide to perform the actual refresh call.
/// Throw [TokenRefreshException] on failure.
typedef RefreshCallback = Future<TokenPair> Function(String refreshToken);

// ─────────────────────────────────────────────────────────────────────────────

/// Intercepts every request to:
///   1. Inject the `Authorization: Bearer <token>` header.
///   2. On 401 – pause all new requests, refresh the access token once,
///      replay queued requests, then continue.
///   3. If refresh also fails – clear tokens and fire [onSessionExpired].
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required Dio dio, this.onTokenRefreshed, this.onSessionExpired}) : _dio = dio;

  final _prefNamespace = "auth";
  final _prefKeyAccessToken = "access_token";
  final _prefKeyRefreshToken = "refresh_token";

  final Dio _dio;
  late final NamespacedPrefs _prefs = PrefsManager.instance.namespace(_prefNamespace);
  final OnTokenRefreshed? onTokenRefreshed;
  final OnSessionExpired? onSessionExpired;

  // Tracks whether a refresh is already in-flight.
  bool _isRefreshing = false;

  // Pending requests that arrived while refresh was running.
  final _queue = <_PendingRequest>[];

  // ── onRequest ────────────────────────────────────────────────────────────

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Public endpoints (login, refresh) opt out via the custom header.
    if (options.headers.containsKey(_kSkipAuth)) {
      options.headers.remove(_kSkipAuth);
      return handler.next(options);
    }

    final token = _prefs.getString(_prefKeyAccessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // ── onError ──────────────────────────────────────────────────────────────

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    final options = err.requestOptions;

    // Only handle 401 and skip if already retried.
    if (response?.statusCode != 401 || options.headers.containsKey(_kRetried)) {
      return handler.next(err);
    }

    // Mark so we never retry twice.
    options.headers[_kRetried] = true;

    if (_isRefreshing) {
      // Another refresh is in flight – queue this request.
      final completer = Completer<Response<dynamic>>();
      _queue.add(_PendingRequest(options: options, completer: completer));

      try {
        final retryResponse = await completer.future;
        return handler.resolve(retryResponse);
      } on DioException catch (e) {
        return handler.next(e);
      }
    }

    // ── We are the first 401 – kick off refresh ──────────────────────────
    _isRefreshing = true;

    try {
      final refreshToken = _prefs.getString(_prefKeyRefreshToken);
      if (refreshToken == null) throw const TokenRefreshException(message: 'No refresh token stored');

      // TODO: implement refresh token
      final pair = await Future.value(TokenPair(accessToken: "", refreshToken: ""));
      // _prefs.setString(_prefKeyAccessToken, pair.accessToken);
      // _prefs.setString(_prefKeyRefreshToken, pair.refreshToken);
      onTokenRefreshed?.call(pair.accessToken, pair.refreshToken);

      // Replay the original request with the new token.
      final retryResponse = await _retry(options, pair.accessToken);

      // Flush the queue – everyone gets the new token.
      _flushQueue(newAccessToken: pair.accessToken);

      return handler.resolve(retryResponse);
    } on TokenRefreshException catch (e) {
      _rejectQueue(e);
      _prefs.clearNamespace();
      onSessionExpired?.call();
      return handler.next(DioException(requestOptions: options, error: e, type: DioExceptionType.badResponse));
    } on DioException catch (e) {
      _rejectQueue(e);
      return handler.next(e);
    } finally {
      _isRefreshing = false;
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Future<Response<dynamic>> _retry(RequestOptions options, String newToken) {
    return _dio.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(method: options.method, headers: {...options.headers, 'Authorization': 'Bearer $newToken'}),
    );
  }

  void _flushQueue({required String newAccessToken}) {
    for (final pending in _queue) {
      _retry(
        pending.options,
        newAccessToken,
      ).then(pending.completer.complete).catchError(pending.completer.completeError);
    }
    _queue.clear();
  }

  void _rejectQueue(Object error) {
    for (final pending in _queue) {
      pending.completer.completeError(error);
    }
    _queue.clear();
  }
}

class _PendingRequest {
  _PendingRequest({required this.options, required this.completer});
  final RequestOptions options;
  final Completer<Response<dynamic>> completer;
}

// ─────────────────────────────────────────────────────────────────────────────

/// Convenience extension so callers can mark public requests without
/// constructing the header key manually.
extension RequestOptionsAuth on RequestOptions {
  RequestOptions skipAuth() {
    headers[_kSkipAuth] = true;
    return this;
  }
}

extension OptionsAuth on Options {
  Options skipAuth() {
    headers ??= {};
    headers![_kSkipAuth] = true;
    return this;
  }
}
