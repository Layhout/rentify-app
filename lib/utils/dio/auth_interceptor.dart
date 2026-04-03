import 'dart:async';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'api_exception.dart';

/// Header key used to skip auth (e.g. login, refresh endpoints).
const _kSkipAuth = 'X-Skip-Auth';

/// Marker added to retried requests so we don't retry twice.
const _kRetried = 'X-Retried';

// ─────────────────────────────────────────────────────────────────────────────

/// Intercepts every request to:
///   1. Inject the `Authorization: Bearer <token>` header.
///   2. On 401 – pause all new requests, refresh the access token once,
///      replay queued requests, then continue.
///   3. If refresh also fails – clear tokens and fire [onSessionExpired].
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required Dio dio}) : _dio = dio;

  final Dio _dio;

  final auth = Supabase.instance.client.auth;

  // Tracks whether a refresh is already in-flight.
  bool _isRefreshing = false;

  // Pending requests that arrived while refresh was running.
  final _queue = <_PendingRequest>[];

  // ── onRequest ────────────────────────────────────────────────────────────

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Public endpoints (login, refresh) opt out via the custom header.
    if (options.headers.containsKey(_kSkipAuth)) {
      options.headers.remove(_kSkipAuth);
      return handler.next(options);
    }

    final token = auth.currentSession?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // ── onError ──────────────────────────────────────────────────────────────

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    final options = err.requestOptions;

    // Only handle 401 and skip if already retried.
    if (response?.statusCode != 401 || options.headers.containsKey(_kRetried)) {
      return handler.next(err);
    }

    // Mark so we never retry twice.
    options.headers[_kRetried] = true;

    if (_isRefreshing) {
      // Another refresh is in flight – queue this request.
      final completer = Completer<Response<dynamic>>();
      _queue.add(_PendingRequest(options: options, completer: completer));

      try {
        final retryResponse = await completer.future;
        return handler.resolve(retryResponse);
      } on DioException catch (e) {
        return handler.next(e);
      }
    }

    // ── We are the first 401 – kick off refresh ──────────────────────────
    _isRefreshing = true;

    try {
      final result = await auth.refreshSession();
      final newToken = result.session!.accessToken;

      // Replay the original request with the new token.
      final retryResponse = await _retry(options, newToken);

      // Flush the queue – everyone gets the new token.
      _flushQueue(newAccessToken: newToken);

      return handler.resolve(retryResponse);
    } on TokenRefreshException catch (e) {
      _rejectQueue(e);
      return handler.next(DioException(requestOptions: options, error: e, type: DioExceptionType.badResponse));
    } on DioException catch (e) {
      _rejectQueue(e);
      return handler.next(e);
    } finally {
      _isRefreshing = false;
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Future<Response<dynamic>> _retry(RequestOptions options, String newToken) {
    return _dio.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(method: options.method, headers: {...options.headers, 'Authorization': 'Bearer $newToken'}),
    );
  }

  void _flushQueue({required String newAccessToken}) {
    for (final pending in _queue) {
      _retry(
        pending.options,
        newAccessToken,
      ).then(pending.completer.complete).catchError(pending.completer.completeError);
    }
    _queue.clear();
  }

  void _rejectQueue(Object error) {
    for (final pending in _queue) {
      pending.completer.completeError(error);
    }
    _queue.clear();
  }
}

class _PendingRequest {
  _PendingRequest({required this.options, required this.completer});
  final RequestOptions options;
  final Completer<Response<dynamic>> completer;
}

// ─────────────────────────────────────────────────────────────────────────────

/// Convenience extension so callers can mark public requests without
/// constructing the header key manually.
extension RequestOptionsAuth on RequestOptions {
  RequestOptions skipAuth() {
    headers[_kSkipAuth] = true;
    return this;
  }
}

extension OptionsAuth on Options {
  Options skipAuth() {
    headers ??= {};
    headers![_kSkipAuth] = true;
    return this;
  }
}
