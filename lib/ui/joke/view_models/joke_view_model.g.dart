// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JokeViewModel)
final jokeViewModelProvider = JokeViewModelProvider._();

final class JokeViewModelProvider
    extends $AsyncNotifierProvider<JokeViewModel, JokeState> {
  JokeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jokeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jokeViewModelHash();

  @$internal
  @override
  JokeViewModel create() => JokeViewModel();
}

String _$jokeViewModelHash() => r'388df8273cebf168d68a02d6ee3090eb16413377';

abstract class _$JokeViewModel extends $AsyncNotifier<JokeState> {
  FutureOr<JokeState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<JokeState>, JokeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<JokeState>, JokeState>,
              AsyncValue<JokeState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
