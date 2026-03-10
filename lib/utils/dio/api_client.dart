import 'package:dio/dio.dart';
import 'package:rentify_app/utils/dio/api_exception.dart';
import 'package:rentify_app/utils/dio/auth_interceptor.dart';
import 'package:rentify_app/utils/dio/error_interceptor.dart';
import 'package:rentify_app/utils/dio/logging_interceptor.dart';

/// Configuration for [ApiClient].
final class ApiClientConfig {
  const ApiClientConfig({
    required this.baseUrl,
    this.onTokenRefreshed,
    this.onSessionExpired,
    this.connectTimeoutMs = 15000,
    this.receiveTimeoutMs = 30000,
    this.sendTimeoutMs = 30000,
    this.enableLogging = true,
    this.logBody = true,
    this.defaultHeaders = const {},
    this.onError,
  });

  final String baseUrl;
  final OnTokenRefreshed? onTokenRefreshed;
  final OnSessionExpired? onSessionExpired;
  final int connectTimeoutMs;
  final int receiveTimeoutMs;
  final int sendTimeoutMs;
  final bool enableLogging;
  final bool logBody;
  final Map<String, dynamic> defaultHeaders;

  /// Global error hook fired after every [ApiException] is mapped.
  final void Function(ApiException)? onError;
}

// ─────────────────────────────────────────────────────────────────────────────

/// A production-grade HTTP client built on [Dio].
///
/// Features:
///   • Automatic `Authorization: Bearer` header injection
///   • Transparent access-token refresh on 401
///   • Request queuing while refresh is in-flight
///   • Typed [ApiException] hierarchy via [ErrorInterceptor]
///   • All results wrapped in [T] – no uncaught exceptions
///
/// ```dart
/// final client = ApiClient(ApiClientConfig(
///   baseUrl: 'https://api.example.com',
///   tokenStorage: SecureTokenStorage(),
///   onRefresh: (token) async {
///     final res = await client.postPublic('/auth/refresh', data: {'refresh_token': token});
///     return TokenPair(
///       accessToken: res.getOrThrow()['access_token'] as String,
///       refreshToken: res.getOrThrow()['refresh_token'] as String,
///     );
///   },
///   onSessionExpired: () => router.go('/login'),
/// ));
/// ```
final class ApiClient {
  ApiClient(ApiClientConfig config) {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: Duration(milliseconds: config.connectTimeoutMs),
        receiveTimeout: Duration(milliseconds: config.receiveTimeoutMs),
        sendTimeout: Duration(milliseconds: config.sendTimeoutMs),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json', ...config.defaultHeaders},
      ),
    );

    // Order matters: logging → auth → error
    if (config.enableLogging) {
      _dio.interceptors.add(LoggingInterceptor(enabled: true, logBody: config.logBody));
    }

    _dio.interceptors.add(
      AuthInterceptor(dio: _dio, onTokenRefreshed: config.onTokenRefreshed, onSessionExpired: config.onSessionExpired),
    );

    _dio.interceptors.add(ErrorInterceptor());
  }

  late final Dio _dio;

  /// Expose the underlying [Dio] instance for advanced use (e.g. adding more
  /// interceptors, or passing a mock adapter in tests).
  Dio get dio => _dio;

  // ── Public-endpoint helpers (no auth header) ────────────────────────────

  /// POST without auth – for login, registration, token refresh, etc.
  Future<T> postPublic<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) => _request<T>(
    method: 'POST',
    path: path,
    data: data,
    queryParameters: queryParameters,
    options: Options().skipAuth(),
  );

  // ── Authenticated helpers ────────────────────────────────────────────────

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) =>
      _request<T>(
        method: 'GET',
        path: path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _request<T>(
    method: 'POST',
    path: path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _request<T>(
    method: 'PUT',
    path: path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<T> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _request<T>(
    method: 'PATCH',
    path: path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _request<T>(
    method: 'DELETE',
    path: path,
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  /// Upload a file with multipart form data.
  Future<T> upload<T>(
    String path, {
    required FormData formData,
    void Function(int sent, int total)? onSendProgress,
    Options? options,
    CancelToken? cancelToken,
  }) => _request<T>(
    method: 'POST',
    path: path,
    data: formData,
    options: (options ?? Options()).copyWith(contentType: 'multipart/form-data'),
    onSendProgress: onSendProgress,
    cancelToken: cancelToken,
  );

  // ── Core request dispatcher ─────────────────────────────────────────────

  Future<T> _request<T>({
    required String method,
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } on DioException catch (e) {
      print('🔴 ======> 213: $e');
      final apiEx = e.error is ApiException
          ? e.error! as ApiException
          : UnknownApiException(message: e.message ?? 'Unknown error');
      throw apiEx;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw UnknownApiException(message: e.toString());
    }
  }
}
