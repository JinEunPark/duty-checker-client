import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 백그라운드 메시지 핸들러 (top-level 함수 필수)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('📩 [FCM] 백그라운드 메시지 수신: ${message.messageId}');
  log('📩 [FCM] 데이터: ${message.data}');
}

/// FCM 푸시 알림 서비스
class FcmService {
  FcmService(this._messaging);

  final FirebaseMessaging _messaging;

  Future<void> initialize() async {
    await _requestPermission();
    await _getToken();
    _listenTokenRefresh();
    _listenForegroundMessages();
    _handleInitialMessage();
    _handleMessageOpenedApp();
    await _setForegroundNotificationOptions();
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

  /// FCM 토큰 발급 및 로그 출력
  Future<void> _getToken() async {
    final token = await _messaging.getToken();
    log('🔑 [FCM] 토큰: $token');
  }

  /// 토큰 갱신 리스닝
  void _listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((token) {
      log('🔄 [FCM] 토큰 갱신: $token');
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

/// FcmService 인스턴스를 제공하는 Provider
///
/// main.dart에서 앱 시작 시 초기화된 FcmService를
/// overrideWithValue()로 주입합니다.
final fcmServiceProvider = Provider<FcmService>(
  (ref) => throw UnimplementedError('main.dart에서 override 필요'),
);
