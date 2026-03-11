import 'package:rentify_app/features/joke/model/joke.dart';

abstract interface class JokeRepository {
  Future<Joke> getJoke();
}
