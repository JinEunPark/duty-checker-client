import 'package:dio/dio.dart';
import 'package:duty_checker/core/network/token_storage.dart';

typedef TokenRefresher = Future<Map<String, String>> Function(
    String refreshToken);

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage, this._dio)
      : _tokenRefresher = null;

  AuthInterceptor.withRefresher(
    this._tokenStorage,
    this._dio,
    this._tokenRefresher,
  );

  final TokenStorage _tokenStorage;
  final Dio _dio;
  final TokenRefresher? _tokenRefresher;

  bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokenStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;
    if (err.response?.statusCode != 401 ||
        path.contains('/v1/auth/refresh') ||
        path.contains('/v1/auth/login')) {
      return handler.next(err);
    }

    final refreshToken = _tokenStorage.refreshToken;
    if (refreshToken == null) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final tokens = await _refreshTokens(refreshToken);
      final newAccessToken = tokens['accessToken']!;
      final newRefreshToken = tokens['refreshToken']!;

      await _tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      // 원래 요청 재시도
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $newAccessToken';

      final retryResponse = await _dio.fetch(options);
      return handler.resolve(retryResponse);
    } on DioException {
      await _tokenStorage.clear();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Map<String, String>> _refreshTokens(String refreshToken) async {
    if (_tokenRefresher != null) {
      return _tokenRefresher(refreshToken);
    }

    final plainDio = Dio(BaseOptions(
      baseUrl: _dio.options.baseUrl,
      connectTimeout: _dio.options.connectTimeout,
      receiveTimeout: _dio.options.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    final response = await plainDio.post(
      '/v1/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    return {
      'accessToken': response.data['accessToken'] as String,
      'refreshToken': response.data['refreshToken'] as String,
    };
  }
}
