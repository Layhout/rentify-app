import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rentify_app/domain/models/joke.dart';

part 'joke_state.freezed.dart';

@freezed
abstract class JokeState with _$JokeState {
  const factory JokeState({required Joke joke}) = _JokeState;
}
