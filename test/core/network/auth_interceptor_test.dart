import 'package:dio/dio.dart';
import 'package:duty_checker/core/network/auth_interceptor.dart';
import 'package:duty_checker/core/network/token_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockTokenStorage mockTokenStorage;
  late Dio dio;

  setUp(() {
    mockTokenStorage = MockTokenStorage();
  });

  /// 테스트용 Dio 생성 (tokenRefresher 콜백 주입 가능)
  Dio createDio({TokenRefresher? refresher}) {
    dio = Dio(BaseOptions(baseUrl: 'https://test.api'));
    if (refresher != null) {
      dio.interceptors
          .add(AuthInterceptor.withRefresher(mockTokenStorage, dio, refresher));
    } else {
      dio.interceptors.add(AuthInterceptor(mockTokenStorage, dio));
    }
    return dio;
  }

  group('AuthInterceptor', () {
    test('요청 헤더에 accessToken을 추가한다', () async {
      when(() => mockTokenStorage.accessToken).thenReturn('test-token');

      dio = createDio();
      dio.httpClientAdapter = _SimpleAdapter((options) {
        expect(options.headers['Authorization'], 'Bearer test-token');
        return _ok();
      });

      await dio.get('/v1/test');
    });

    test('accessToken이 없으면 Authorization 헤더를 추가하지 않는다', () async {
      when(() => mockTokenStorage.accessToken).thenReturn(null);

      dio = createDio();
      dio.httpClientAdapter = _SimpleAdapter((options) {
        expect(options.headers.containsKey('Authorization'), false);
        return _ok();
      });

      final response = await dio.get('/v1/test');
      expect(response.statusCode, 200);
    });

    test('401 응답 시 토큰을 갱신하고 원래 요청을 재시도한다', () async {
      var currentAccessToken = 'expired-token';
      when(() => mockTokenStorage.accessToken)
          .thenAnswer((_) => currentAccessToken);
      when(() => mockTokenStorage.refreshToken).thenReturn('valid-refresh');
      when(() => mockTokenStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((invocation) async {
        currentAccessToken =
            invocation.namedArguments[#accessToken] as String;
      });

      var callCount = 0;
      dio = createDio(
        refresher: (refreshToken) async {
          expect(refreshToken, 'valid-refresh');
          return {
            'accessToken': 'new-access',
            'refreshToken': 'new-refresh',
          };
        },
      );

      dio.httpClientAdapter = _SimpleAdapter((options) {
        callCount++;
        if (callCount == 1) {
          throw DioException(
            requestOptions: options,
            response: Response(requestOptions: options, statusCode: 401),
            type: DioExceptionType.badResponse,
          );
        }
        // 재시도: 새 토큰이 헤더에 설정되었는지 확인
        expect(options.headers['Authorization'], 'Bearer new-access');
        return _jsonResponse({'data': 'success'});
      });

      final response = await dio.get('/v1/test');

      expect(response.statusCode, 200);
      verify(() => mockTokenStorage.saveTokens(
            accessToken: 'new-access',
            refreshToken: 'new-refresh',
          )).called(1);
    });

    test('refresh 토큰이 없으면 401을 그대로 전파한다', () async {
      when(() => mockTokenStorage.accessToken).thenReturn('expired-token');
      when(() => mockTokenStorage.refreshToken).thenReturn(null);

      dio = createDio();
      dio.httpClientAdapter = _SimpleAdapter((options) {
        throw DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        );
      });

      await expectLater(
        () => dio.get('/v1/test'),
        throwsA(isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          401,
        )),
      );
    });

    test('refresh 요청 자체가 실패하면 토큰을 삭제하고 원래 에러를 전파한다', () async {
      when(() => mockTokenStorage.accessToken).thenReturn('expired-token');
      when(() => mockTokenStorage.refreshToken).thenReturn('invalid-refresh');
      when(() => mockTokenStorage.clear()).thenAnswer((_) async {});

      dio = createDio(
        refresher: (refreshToken) async {
          throw DioException(
            requestOptions: RequestOptions(path: '/v1/auth/refresh'),
            type: DioExceptionType.badResponse,
          );
        },
      );

      dio.httpClientAdapter = _SimpleAdapter((options) {
        throw DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        );
      });

      await expectLater(
        () => dio.get('/v1/test'),
        throwsA(isA<DioException>()),
      );
      verify(() => mockTokenStorage.clear()).called(1);
    });

    test('로그인 API의 401은 갱신 시도하지 않고 그대로 전파한다', () async {
      when(() => mockTokenStorage.accessToken).thenReturn(null);

      dio = createDio();
      dio.httpClientAdapter = _SimpleAdapter((options) {
        throw DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        );
      });

      await expectLater(
        () => dio.post('/v1/auth/login'),
        throwsA(isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          401,
        )),
      );
    });

    test('refresh API의 401은 갱신 시도하지 않고 그대로 전파한다', () async {
      when(() => mockTokenStorage.accessToken).thenReturn('token');

      dio = createDio();
      dio.httpClientAdapter = _SimpleAdapter((options) {
        throw DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
          type: DioExceptionType.badResponse,
        );
      });

      await expectLater(
        () => dio.post('/v1/auth/refresh'),
        throwsA(isA<DioException>().having(
          (e) => e.response?.statusCode,
          'statusCode',
          401,
        )),
      );
    });
  });
}

ResponseBody _ok() {
  return ResponseBody.fromString(
    '{}',
    200,
    headers: {'content-type': ['application/json']},
  );
}

ResponseBody _jsonResponse(Map<String, dynamic> data) {
  final entries = data.entries.map((e) => '"${e.key}":"${e.value}"').join(',');
  return ResponseBody.fromString(
    '{$entries}',
    200,
    headers: {'content-type': ['application/json']},
  );
}

class _SimpleAdapter implements HttpClientAdapter {
  _SimpleAdapter(this._handler);

  final ResponseBody Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}
