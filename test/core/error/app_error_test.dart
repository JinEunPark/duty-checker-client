import 'dart:io';

import 'package:dio/dio.dart';
import 'package:duty_checker/core/error/app_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppError.from', () {
    group('DioException 변환', () {
      test('connectionTimeout → timeout 타입', () {
        final error = AppError.from(DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(),
        ));

        expect(error.type, AppErrorType.timeout);
        expect(error.message, contains('서버 응답이 느려요'));
      });

      test('sendTimeout → timeout 타입', () {
        final error = AppError.from(DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(),
        ));

        expect(error.type, AppErrorType.timeout);
      });

      test('receiveTimeout → timeout 타입', () {
        final error = AppError.from(DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(),
        ));

        expect(error.type, AppErrorType.timeout);
      });

      test('connectionError → network 타입', () {
        final error = AppError.from(DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(),
        ));

        expect(error.type, AppErrorType.network);
        expect(error.message, contains('인터넷 연결'));
      });

      test('cancel → unknown 타입', () {
        final error = AppError.from(DioException(
          type: DioExceptionType.cancel,
          requestOptions: RequestOptions(),
        ));

        expect(error.type, AppErrorType.unknown);
        expect(error.message, contains('취소'));
      });
    });

    group('HTTP 상태 코드 변환', () {
      AppError fromStatus(int statusCode, {dynamic data}) {
        return AppError.from(DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: statusCode,
            requestOptions: RequestOptions(),
            data: data,
          ),
        ));
      }

      test('400 → badRequest', () {
        final error = fromStatus(400);
        expect(error.type, AppErrorType.badRequest);
        expect(error.statusCode, 400);
      });

      test('401 → unauthorized', () {
        final error = fromStatus(401);
        expect(error.type, AppErrorType.unauthorized);
        expect(error.statusCode, 401);
      });

      test('403 → forbidden', () {
        final error = fromStatus(403);
        expect(error.type, AppErrorType.forbidden);
      });

      test('404 → notFound', () {
        final error = fromStatus(404);
        expect(error.type, AppErrorType.notFound);
      });

      test('409 → conflict', () {
        final error = fromStatus(409);
        expect(error.type, AppErrorType.conflict);
      });

      test('429 → rateLimited', () {
        final error = fromStatus(429);
        expect(error.type, AppErrorType.rateLimited);
      });

      test('500 → server', () {
        final error = fromStatus(500);
        expect(error.type, AppErrorType.server);
      });

      test('503 → server', () {
        final error = fromStatus(503);
        expect(error.type, AppErrorType.server);
      });
    });

    group('서버 에러코드 파싱', () {
      AppError fromServerCode(String code, {int statusCode = 400}) {
        return AppError.from(DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: statusCode,
            requestOptions: RequestOptions(),
            data: {'code': code, 'message': '서버 원본 메시지'},
          ),
        ));
      }

      test('INVALID_PHONE_FORMAT → 전화번호 형식 안내', () {
        final error = fromServerCode('INVALID_PHONE_FORMAT');
        expect(error.type, AppErrorType.badRequest);
        expect(error.message, contains('전화번호 형식'));
      });

      test('INVALID_CREDENTIALS → 인증 실패 안내', () {
        final error = fromServerCode('INVALID_CREDENTIALS', statusCode: 401);
        expect(error.type, AppErrorType.unauthorized);
        expect(error.message, contains('비밀번호가 일치하지 않아요'));
      });

      test('CODE_EXPIRED → 만료 안내', () {
        final error = fromServerCode('CODE_EXPIRED');
        expect(error.type, AppErrorType.badRequest);
        expect(error.message, contains('만료'));
      });

      test('CODE_MISMATCH → 불일치 안내', () {
        final error = fromServerCode('CODE_MISMATCH');
        expect(error.type, AppErrorType.badRequest);
        expect(error.message, contains('일치하지 않아요'));
      });

      test('RESEND_COOLDOWN → 재시도 안내', () {
        final error = fromServerCode('RESEND_COOLDOWN', statusCode: 429);
        expect(error.type, AppErrorType.rateLimited);
        expect(error.message, contains('잠시 후'));
      });

      test('VERIFICATION_ATTEMPTS_EXCEEDED → 횟수 초과 안내', () {
        final error = fromServerCode('VERIFICATION_ATTEMPTS_EXCEEDED', statusCode: 429);
        expect(error.type, AppErrorType.rateLimited);
        expect(error.message, contains('횟수'));
      });

      test('PHONE_ALREADY_REGISTERED → 중복 가입 안내', () {
        final error = fromServerCode('PHONE_ALREADY_REGISTERED', statusCode: 409);
        expect(error.type, AppErrorType.conflict);
        expect(error.message, contains('이미 가입'));
      });

      test('PHONE_NOT_VERIFIED → 인증 필요 안내', () {
        final error = fromServerCode('PHONE_NOT_VERIFIED');
        expect(error.type, AppErrorType.badRequest);
        expect(error.message, contains('인증을 먼저'));
      });

      test('알 수 없는 서버 코드는 서버 메시지를 사용한다', () {
        final error = AppError.from(DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(),
            data: {'code': 'UNKNOWN_CODE', 'message': '커스텀 에러 메시지'},
          ),
        ));

        expect(error.type, AppErrorType.badRequest);
        expect(error.message, '커스텀 에러 메시지');
      });
    });

    group('기타 예외 변환', () {
      test('SocketException → network 타입', () {
        final error = AppError.from(const SocketException('연결 실패'));
        expect(error.type, AppErrorType.network);
        expect(error.message, contains('인터넷 연결'));
      });

      test('일반 Exception → unknown 타입', () {
        final error = AppError.from(Exception('알 수 없는 에러'));
        expect(error.type, AppErrorType.unknown);
      });

      test('String 에러 → unknown 타입', () {
        final error = AppError.from('문자열 에러');
        expect(error.type, AppErrorType.unknown);
      });
    });

    test('toString은 message를 반환한다', () {
      const error = AppError(
        type: AppErrorType.network,
        message: '테스트 메시지',
      );
      expect(error.toString(), '테스트 메시지');
    });
  });
}
