import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:duty_checker/core/fcm/device_token_api.dart';
import 'package:duty_checker/core/fcm/update_device_token_req_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 백그라운드 메시지 핸들러 (top-level 함수 필수)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('📩 [FCM] 백그라운드 메시지 수신: ${message.messageId}');
  log('📩 [FCM] 데이터: ${message.data}');
}

/// FCM 푸시 알림 서비스
class FcmService {
  FcmService({required FirebaseMessaging messaging}) : _messaging = messaging;

  final FirebaseMessaging _messaging;
  DeviceTokenApi? _deviceTokenApi;
  String? _pendingToken;

  @visibleForTesting
  DeviceTokenApi? get deviceTokenApiForTest => _deviceTokenApi;
  @visibleForTesting
  set deviceTokenApiForTest(DeviceTokenApi? api) => _deviceTokenApi = api;

  @visibleForTesting
  String? get pendingToken => _pendingToken;
  @visibleForTesting
  set pendingToken(String? value) => _pendingToken = value;

  @visibleForTesting
  Future<void> sendTokenToServer(String token) => _sendTokenToServer(token);

  /// 로그인 성공 후 호출 — API 설정 및 캐싱된 토큰 즉시 전송
  Future<void> connectApi(Dio dio) async {
    _deviceTokenApi = DeviceTokenApi(dio);
    try {
      final token = _pendingToken ?? await _messaging.getToken();
      if (token != null) await _sendTokenToServer(token);
    } catch (e) {
      log('❌ [FCM] 토큰 전송 실패: $e');
    }
  }

  Future<void> _sendTokenToServer(String token) async {
    final api = _deviceTokenApi;
    if (api == null) {
      _pendingToken = token;
      log('🔑 [FCM] API 미연결 — 토큰 캐싱');
      return;
    }

    try {
      await api.updateDeviceToken(UpdateDeviceTokenReqModel(fcmToken: token));
      _pendingToken = null;
      log('✅ [FCM] 서버 토큰 갱신 완료');
    } catch (e) {
      _pendingToken = token;
      log('❌ [FCM] 서버 토큰 갱신 실패: $e');
    }
  }

  Future<void> initialize() async {
    await _requestPermission();
    _listenTokenRefresh();
    _listenForegroundMessages();
    _handleInitialMessage();
    _handleMessageOpenedApp();
    await _setForegroundNotificationOptions();
    await _getToken();
  }

  /// 알림 권한 요청 (iOS 시스템 다이얼로그 / Android 13+)
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('🔔 [FCM] 알림 권한 상태: ${settings.authorizationStatus}');
  }

  /// FCM 토큰 발급 및 캐싱 (API 연결 전이면 캐싱만)
  Future<void> _getToken() async {
    if (Platform.isIOS) {
      String? apnsToken;
      var delay = const Duration(milliseconds: 500);
      for (var i = 0; i < 5; i++) {
        apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null) break;
        await Future.delayed(delay);
        delay *= 2;
      }
      if (apnsToken == null) {
        return;
      }
    }
    try {
      final token = await _messaging.getToken();
      if (token != null) await _sendTokenToServer(token);

      log('🔑 [FCM] 토큰: $token');
    } catch (e) {
      log('❌ [FCM] 토큰 발급 실패: $e');
    }
  }

  /// 토큰 갱신 리스닝
  void _listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((token) async {
      await _sendTokenToServer(token);
    });
  }

  /// 포그라운드 메시지 수신 리스닝
  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('📬 [FCM] 포그라운드 메시지 수신: ${message.messageId}');
      log('📬 [FCM] 제목: ${message.notification?.title}');
      log('📬 [FCM] 본문: ${message.notification?.body}');
      log('📬 [FCM] 데이터: ${message.data}');
    });
  }

  /// 앱이 종료 상태에서 알림 탭으로 열렸을 때 처리
  void _handleInitialMessage() {
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        log('🚀 [FCM] 종료 상태에서 알림 탭: ${message.data}');
      }
    });
  }

  /// 앱이 백그라운드 상태에서 알림 탭으로 열렸을 때 처리
  void _handleMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('👆 [FCM] 백그라운드에서 알림 탭: ${message.data}');
    });
  }

  /// iOS 포그라운드 알림 표시 옵션 설정
  Future<void> _setForegroundNotificationOptions() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

final fcmServiceProvider = Provider<FcmService>(
  (ref) => throw UnimplementedError('main.dart에서 override 필요'),
);
