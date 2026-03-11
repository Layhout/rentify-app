import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Pretty-prints requests and responses to the console.
/// Disable or replace with your preferred logger in production.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor({this.enabled = true, this.logBody = true});

  final bool enabled;

  /// Set to `false` to omit request / response bodies (e.g. for binary data).
  final bool logBody;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      _log('→ ${options.method} ${options.uri}');
      if (logBody && options.data != null) _log('  body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (enabled) {
      _log('← ${response.statusCode} ${response.requestOptions.uri}');
      if (logBody) _log('  data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {
      _log(
        '✕ ${err.response?.statusCode ?? err.type.name} '
        '${err.requestOptions.uri} – ${err.message}',
      );
    }
    handler.next(err);
  }

  void _log(String message) {
    debugPrint('🌐 [ApiClient] $message');
  }
}
