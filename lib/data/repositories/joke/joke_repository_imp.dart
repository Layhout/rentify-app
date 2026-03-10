import 'package:dio/dio.dart';
import 'package:rentify_app/config/providers/joke_api/joke_api_provider.dart';
import 'package:rentify_app/data/model/joke/joke_model.dart';
import 'package:rentify_app/data/repositories/joke/joke_repository.dart';
import 'package:rentify_app/domain/models/joke.dart';
import 'package:rentify_app/utils/dio/api_client.dart';
import 'package:rentify_app/utils/dio/auth_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'joke_repository_imp.g.dart';

@riverpod
JokeRepository jokeRepository(Ref ref) {
  return JokeRepositoryImp(apiClient: ref.watch(jokeApiClientProvider));
}

class JokeRepositoryImp implements JokeRepository {
  JokeRepositoryImp({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Joke> getJoke() async {
    final jokeMap = await apiClient.get<Map<String, dynamic>>("", options: Options().skipAuth());
    return JokeModel.fromJson(jokeMap);
  }
}
