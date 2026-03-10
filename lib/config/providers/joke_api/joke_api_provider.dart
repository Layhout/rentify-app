import 'package:rentify_app/utils/dio/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'joke_api_provider.g.dart';

@riverpod
ApiClient jokeApiClient(Ref ref) {
  return ApiClient(ApiClientConfig(baseUrl: "https://official-joke-api.appspot.com/random_joke"));
}
