// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_listener_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthListener)
final authListenerProvider = AuthListenerProvider._();

final class AuthListenerProvider
    extends $NotifierProvider<AuthListener, AuthState> {
  AuthListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authListenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authListenerHash();

  @$internal
  @override
  AuthListener create() => AuthListener();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authListenerHash() => r'980f169d9a442a9c6e35a12b2753956fb8af3e54';

abstract class _$AuthListener extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
