import 'package:rentify_app/features/joke/repository/joke_repository.dart';
import 'package:rentify_app/features/joke/repository/joke_repository_imp.dart';
import 'package:rentify_app/features/joke/provider/joke_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'joke_view_model.g.dart';

@riverpod
class JokeViewModel extends _$JokeViewModel {
  late final JokeRepository _repo;

  @override
  Future<JokeState> build() async {
    _repo = ref.watch(jokeRepositoryProvider);
    final joke = await _repo.getJoke();
    return JokeState(joke: joke);
  }

  Future<void> getNewJoke() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final joke = await _repo.getJoke();
      return JokeState(joke: joke);
    });
  }
}
