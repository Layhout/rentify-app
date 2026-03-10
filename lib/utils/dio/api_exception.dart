/// Base class for all API-layer exceptions.
sealed class ApiException implements Exception {
  const ApiException({required this.message});
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The server returned a non-2xx response.
final class HttpException extends ApiException {
  const HttpException({required this.statusCode, required super.message, this.data});

  final int statusCode;

  /// Raw response body (Map, List, or String).
  final Object? data;
}

/// 401 – credentials are invalid / missing.
final class UnauthorizedException extends HttpException {
  const UnauthorizedException({super.message = 'Unauthorized', super.data}) : super(statusCode: 401);
}

/// 403 – authenticated but not permitted.
final class ForbiddenException extends HttpException {
  const ForbiddenException({super.message = 'Forbidden', super.data}) : super(statusCode: 403);
}

/// 404 – resource not found.
final class NotFoundException extends HttpException {
  const NotFoundException({super.message = 'Not Found', super.data}) : super(statusCode: 404);
}

/// 422 – validation / unprocessable entity.
final class UnprocessableException extends HttpException {
  const UnprocessableException({super.message = 'Unprocessable Entity', super.data}) : super(statusCode: 422);
}

/// 5xx – server blew up.
final class ServerException extends HttpException {
  const ServerException({required super.statusCode, super.message = 'Internal Server Error', super.data});
}

/// The token refresh call itself failed (prevents infinite loops).
final class TokenRefreshException extends ApiException {
  const TokenRefreshException({super.message = 'Failed to refresh token'});
}

/// No internet / connection timed out.
final class NetworkException extends ApiException {
  const NetworkException({super.message = 'Network error'});
}

/// Request was cancelled.
final class CancelledException extends ApiException {
  const CancelledException({super.message = 'Request cancelled'});
}

/// Catch-all for anything unexpected.
final class UnknownApiException extends ApiException {
  const UnknownApiException({super.message = 'Unknown error'});
}
