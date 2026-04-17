import 'dart:io';

import 'package:dio/dio.dart';

/// 앱 전체에서 사용하는 에러 타입
enum AppErrorType {
  /// 네트워크 연결 없음
  network,

  /// 서버 응답 타임아웃
  timeout,

  /// 인증 실패 (401)
  unauthorized,

  /// 권한 없음 (403)
  forbidden,

  /// 리소스 없음 (404)
  notFound,

  /// 중복 (409)
  conflict,

  /// 요청 제한 (429)
  rateLimited,

  /// 잘못된 요청 (400)
  badRequest,

  /// 서버 에러 (500+)
  server,

  /// 알 수 없는 에러
  unknown,
}

class AppError implements Exception {
  final AppErrorType type;
  final String message;
  final int? statusCode;

  const AppError({
    required this.type,
    required this.message,
    this.statusCode,
  });

  /// DioException → AppError 변환
  factory AppError.from(Object error) {
    if (error is DioException) {
      return _fromDio(error);
    }
    if (error is SocketException) {
      return const AppError(
        type: AppErrorType.network,
        message: '인터넷 연결을 확인해주세요.',
      );
    }
    return AppError(
      type: AppErrorType.unknown,
      message: '알 수 없는 오류가 발생했어요.\n잠시 후 다시 시도해주세요.',
    );
  }

  static AppError _fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppError(
          type: AppErrorType.timeout,
          message: '서버 응답이 느려요.\n잠시 후 다시 시도해주세요.',
        );

      case DioExceptionType.connectionError:
        return const AppError(
          type: AppErrorType.network,
          message: '인터넷 연결을 확인해주세요.',
        );

      case DioExceptionType.badResponse:
        return _fromResponse(e.response);

      case DioExceptionType.cancel:
        return const AppError(
          type: AppErrorType.unknown,
          message: '요청이 취소되었어요.',
        );

      default:
        return const AppError(
          type: AppErrorType.unknown,
          message: '알 수 없는 오류가 발생했어요.\n잠시 후 다시 시도해주세요.',
        );
    }
  }

  /// 서버 응답 body에서 에러코드 파싱 후 매핑
  static AppError _fromResponse(Response? response) {
    final code = response?.statusCode;
    final data = response?.data;

    // 서버가 { "code": "...", "message": "..." } 형태로 응답하는 경우
    if (data is Map<String, dynamic>) {
      final serverCode = data['code'] as String?;
      final serverMessage = data['message'] as String?;

      final mapped = _serverCodeMessages[serverCode];
      if (mapped != null) {
        return AppError(
          type: mapped.$1,
          statusCode: code,
          message: mapped.$2,
        );
      }

      // 알려진 코드가 아니지만 서버 메시지가 있는 경우
      if (serverMessage != null && serverMessage.isNotEmpty) {
        return AppError(
          type: _typeFromStatusCode(code),
          statusCode: code,
          message: serverMessage,
        );
      }
    }

    return _fromStatusCode(code);
  }

  /// 서버 에러코드 → (에러타입, 사용자 메시지) 매핑
  static const _serverCodeMessages = <String, (AppErrorType, String)>{
    // 인증
    'INVALID_PHONE_FORMAT': (AppErrorType.badRequest, '올바른 전화번호 형식을 입력해주세요.'),
    'INVALID_CREDENTIALS': (AppErrorType.unauthorized, '전화번호 또는 비밀번호가 일치하지 않아요.'),

    // 인증코드
    'CODE_EXPIRED': (AppErrorType.badRequest, '인증코드가 만료되었어요.\n다시 요청해주세요.'),
    'CODE_MISMATCH': (AppErrorType.badRequest, '인증코드가 일치하지 않아요.\n다시 확인해주세요.'),
    'RESEND_COOLDOWN': (AppErrorType.rateLimited, '잠시 후 다시 요청해주세요.'),
    'VERIFICATION_ATTEMPTS_EXCEEDED': (AppErrorType.rateLimited, '인증 시도 횟수를 초과했어요.\n잠시 후 다시 시도해주세요.'),

    // 회원가입
    'PHONE_ALREADY_REGISTERED': (AppErrorType.conflict, '이미 가입된 전화번호예요.'),
    'PHONE_NOT_VERIFIED': (AppErrorType.badRequest, '전화번호 인증을 먼저 완료해주세요.'),

    // 연결
    'SAME_ROLE_CONNECTION': (AppErrorType.badRequest, '같은 역할끼리는 연결할 수 없어요.'),
    'INVALID_CONNECTION_ROLES': (AppErrorType.badRequest, '당사자와 보호자 간에만 연결이 가능해요.'),
    'USER_NOT_FOUND': (AppErrorType.notFound, '해당 사용자를 찾을 수 없어요.'),
    'CONNECTION_ALREADY_EXISTS': (AppErrorType.conflict, '이미 연결 요청을 보냈어요.'),
    'INVALID_CONNECTION_STATUS': (AppErrorType.badRequest, '유효하지 않은 연결 상태예요.'),
    'OWN_CONNECTION_REQUEST': (AppErrorType.forbidden, '본인의 연결 요청은 직접 처리할 수 없어요.'),
    'CONNECTION_NOT_FOUND': (AppErrorType.notFound, '연결 정보를 찾을 수 없어요.'),
    'CONNECTION_ALREADY_PROCESSED': (AppErrorType.conflict, '이미 처리된 연결 요청이에요.'),
    'NOT_CONNECTION_OWNER': (AppErrorType.forbidden, '본인의 연결만 수정할 수 있어요.'),
    'NOT_RELATED_CONNECTION': (AppErrorType.forbidden, '본인과 관련된 연결이 아니에요.'),

    // 체크인
    'ALREADY_CHECKED_IN': (AppErrorType.badRequest, '오늘은 이미 안부를 전달했어요.'),

    // 비밀번호 재설정
    'PHONE_NOT_AUTHENTICATED': (AppErrorType.unauthorized, '전화번호 인증을 먼저 완료해주세요.'),
  };

  static AppErrorType _typeFromStatusCode(int? code) {
    return switch (code) {
      400 => AppErrorType.badRequest,
      401 => AppErrorType.unauthorized,
      403 => AppErrorType.forbidden,
      404 => AppErrorType.notFound,
      409 => AppErrorType.conflict,
      429 => AppErrorType.rateLimited,
      int c when c >= 500 => AppErrorType.server,
      _ => AppErrorType.unknown,
    };
  }

  static AppError _fromStatusCode(int? code) {
    return switch (code) {
      400 => const AppError(type: AppErrorType.badRequest, statusCode: 400, message: '요청 정보를 다시 확인해주세요.'),
      401 => const AppError(type: AppErrorType.unauthorized, statusCode: 401, message: '인증에 실패했어요.\n다시 로그인해주세요.'),
      403 => const AppError(type: AppErrorType.forbidden, statusCode: 403, message: '접근 권한이 없어요.'),
      404 => const AppError(type: AppErrorType.notFound, statusCode: 404, message: '요청하신 정보를 찾을 수 없어요.'),
      409 => const AppError(type: AppErrorType.conflict, statusCode: 409, message: '이미 처리된 요청이에요.'),
      429 => const AppError(type: AppErrorType.rateLimited, statusCode: 429, message: '요청이 너무 많아요.\n잠시 후 다시 시도해주세요.'),
      int c when c >= 500 => AppError(type: AppErrorType.server, statusCode: code, message: '서버에 문제가 발생했어요.\n잠시 후 다시 시도해주세요.'),
      _ => AppError(type: AppErrorType.unknown, statusCode: code, message: '알 수 없는 오류가 발생했어요.\n잠시 후 다시 시도해주세요.'),
    };
  }

  @override
  String toString() => message;
}
