import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rentify_app/utils/dio/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient(ApiClientConfig(baseUrl: dotenv.env['BASE_URL']!));
}
