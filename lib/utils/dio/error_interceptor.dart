import 'package:dio/dio.dart';
import 'api_exception.dart';

/// Converts raw [DioException]s into descriptive [ApiException] subtypes
/// so callers never have to inspect `statusCode` themselves.
class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  /// Optional global error hook (logging, analytics, etc.).
  // final void Function(ApiException)? onError;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiException = _map(err);
    // this.onError?.call(apiException);

    // Replace the DioException's `error` field so callers can catch
    // ApiException directly from the error wrapper.
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: apiException,
        message: apiException.message,
        stackTrace: err.stackTrace,
      ),
    );
  }

  ApiException _map(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.cancel:
        return const CancelledException();

      case DioExceptionType.badResponse:
        return _mapResponse(err.response);

      case DioExceptionType.unknown:
        // Re-throw ApiExceptions that were already mapped (e.g. by AuthInterceptor).
        if (err.error is ApiException) return err.error! as ApiException;
        return UnknownApiException(message: err.message ?? 'Unknown error');

      // ignore: deprecated_member_use
      case DioExceptionType.badCertificate:
        return NetworkException(message: 'Bad certificate: ${err.message}');
    }
  }

  ApiException _mapResponse(Response<dynamic>? response) {
    if (response == null) return const UnknownApiException();

    final statusCode = response.statusCode ?? -1;
    final data = response.data;
    final message = _extractMessage(data) ?? response.statusMessage ?? 'HTTP $statusCode';

    return switch (statusCode) {
      401 => UnauthorizedException(message: message, data: data),
      403 => ForbiddenException(message: message, data: data),
      404 => NotFoundException(message: message, data: data),
      422 => UnprocessableException(message: message, data: data),
      >= 500 => ServerException(statusCode: statusCode, message: message, data: data),
      _ => HttpException(statusCode: statusCode, message: message, data: data),
    };
  }

  /// Tries to pull a human-readable message from common JSON shapes:
  ///   { "message": "..." }
  ///   { "error": "..." }
  ///   { "detail": "..." }
  ///   { "errors": ["...", ...] }
  String? _extractMessage(dynamic data) {
    if (data is! Map<String, dynamic>) return null;
    if (data['message'] is String) return data['message'] as String;
    if (data['error'] is String) return data['error'] as String;
    if (data['detail'] is String) return data['detail'] as String;
    if (data['errors'] is List) {
      final errors = data['errors'] as List;
      return errors.whereType<String>().join('; ');
    }
    return null;
  }
}
