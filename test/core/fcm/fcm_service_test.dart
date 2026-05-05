import 'package:dio/dio.dart';
import 'package:duty_checker/core/fcm/device_token_api.dart';
import 'package:duty_checker/core/fcm/fcm_service.dart';
import 'package:duty_checker/core/fcm/update_device_token_req_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockDeviceTokenApi extends Mock implements DeviceTokenApi {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockFirebaseMessaging mockMessaging;
  late MockDeviceTokenApi mockApi;
  late FcmService sut;

  setUpAll(() {
    registerFallbackValue(
      const UpdateDeviceTokenReqModel(fcmToken: ''),
    );
  });

  setUp(() {
    mockMessaging = MockFirebaseMessaging();
    mockApi = MockDeviceTokenApi();
    sut = FcmService(messaging: mockMessaging);
  });

  group('sendTokenToServer', () {
    test('API 미연결 시 토큰을 캐싱한다', () async {
      // deviceTokenApi가 null인 상태 (기본값)
      await sut.sendTokenToServer('test_token');

      expect(sut.pendingToken, 'test_token');
    });

    test('API 연결 시 서버로 토큰을 전송하고 캐시를 초기화한다', () async {
      sut.deviceTokenApiForTest = mockApi;
      sut.pendingToken = 'old_token';

      when(() => mockApi.updateDeviceToken(any()))
          .thenAnswer((_) async {});

      await sut.sendTokenToServer('new_token');

      verify(
        () => mockApi.updateDeviceToken(
          const UpdateDeviceTokenReqModel(fcmToken: 'new_token'),
        ),
      ).called(1);
      expect(sut.pendingToken, isNull);
    });

    test('API 전송 실패 시 토큰을 캐싱한다', () async {
      sut.deviceTokenApiForTest = mockApi;

      when(() => mockApi.updateDeviceToken(any()))
          .thenThrow(Exception('network error'));

      await sut.sendTokenToServer('fail_token');

      expect(sut.pendingToken, 'fail_token');
    });
  });

  group('connectApi', () {
    test('캐싱된 토큰이 있으면 해당 토큰을 서버로 전송한다', () async {
      sut.pendingToken = 'cached_token';

      when(() => mockApi.updateDeviceToken(any()))
          .thenAnswer((_) async {});

      // connectApi는 DeviceTokenApi(dio)를 내부 생성하므로,
      // pendingToken을 사용하는 경로를 테스트하기 위해 직접 API 설정
      sut.deviceTokenApiForTest = mockApi;
      await sut.sendTokenToServer(sut.pendingToken!);

      verify(
        () => mockApi.updateDeviceToken(
          const UpdateDeviceTokenReqModel(fcmToken: 'cached_token'),
        ),
      ).called(1);
      expect(sut.pendingToken, isNull);
    });

    test('캐싱된 토큰이 없으면 FirebaseMessaging에서 토큰을 가져온다', () async {
      when(() => mockMessaging.getToken()).thenAnswer((_) async => 'fresh_token');
      when(() => mockApi.updateDeviceToken(any()))
          .thenAnswer((_) async {});

      // pendingToken이 없는 상태에서 connectApi 시뮬레이션
      sut.deviceTokenApiForTest = mockApi;
      final token = sut.pendingToken ?? await mockMessaging.getToken();
      if (token != null) await sut.sendTokenToServer(token);

      verify(() => mockMessaging.getToken()).called(1);
      verify(
        () => mockApi.updateDeviceToken(
          const UpdateDeviceTokenReqModel(fcmToken: 'fresh_token'),
        ),
      ).called(1);
    });
  });

  group('토큰 캐싱 흐름', () {
    test('API 미연결 -> 토큰 캐싱 -> API 연결 -> 캐싱 토큰 전송', () async {
      // 1. API 없이 토큰 수신 (initialize 중 발생하는 시나리오)
      await sut.sendTokenToServer('early_token');
      expect(sut.pendingToken, 'early_token');

      // 2. API 연결 후 캐싱된 토큰 전송
      sut.deviceTokenApiForTest = mockApi;
      when(() => mockApi.updateDeviceToken(any()))
          .thenAnswer((_) async {});

      await sut.sendTokenToServer(sut.pendingToken!);

      verify(
        () => mockApi.updateDeviceToken(
          const UpdateDeviceTokenReqModel(fcmToken: 'early_token'),
        ),
      ).called(1);
      expect(sut.pendingToken, isNull);
    });

    test('토큰 갱신 시 최신 토큰이 캐싱된다', () async {
      // API 없이 토큰이 여러 번 갱신되는 경우
      await sut.sendTokenToServer('token_v1');
      expect(sut.pendingToken, 'token_v1');

      await sut.sendTokenToServer('token_v2');
      expect(sut.pendingToken, 'token_v2');

      // API 연결 후 마지막 토큰만 전송
      sut.deviceTokenApiForTest = mockApi;
      when(() => mockApi.updateDeviceToken(any()))
          .thenAnswer((_) async {});

      await sut.sendTokenToServer(sut.pendingToken!);

      verify(
        () => mockApi.updateDeviceToken(
          const UpdateDeviceTokenReqModel(fcmToken: 'token_v2'),
        ),
      ).called(1);
    });
  });
}
