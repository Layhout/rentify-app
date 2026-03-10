// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_repository_imp.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jokeRepository)
final jokeRepositoryProvider = JokeRepositoryProvider._();

final class JokeRepositoryProvider
    extends $FunctionalProvider<JokeRepository, JokeRepository, JokeRepository>
    with $Provider<JokeRepository> {
  JokeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jokeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jokeRepositoryHash();

  @$internal
  @override
  $ProviderElement<JokeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JokeRepository create(Ref ref) {
    return jokeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JokeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JokeRepository>(value),
    );
  }
}

String _$jokeRepositoryHash() => r'f9274196dbabf85ae65fb3a5adfb46cea997df0b';
