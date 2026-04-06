// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignupViewModel)
final signupViewModelProvider = SignupViewModelProvider._();

final class SignupViewModelProvider
    extends $AsyncNotifierProvider<SignupViewModel, void> {
  SignupViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signupViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signupViewModelHash();

  @$internal
  @override
  SignupViewModel create() => SignupViewModel();
}

String _$signupViewModelHash() => r'8282aa7b424a8e4c8498fb29e35a3775557209c9';

abstract class _$SignupViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
