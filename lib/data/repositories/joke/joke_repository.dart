import 'package:rentify_app/domain/models/joke.dart';

abstract interface class JokeRepository {
  Future<Joke> getJoke();
}
