import 'package:dio/dio.dart';
import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/view_model/sign_up_view_model.dart';
import 'package:duty_checker/core/error/app_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockCheckPhoneUseCase mockCheckPhone;
  late MockSendCodeUseCase mockSendCode;
  late MockVerifyCodeUseCase mockVerifyCode;
  late MockRegisterUseCase mockRegister;
  late MockLoginUseCase mockLogin;
  late ProviderContainer container;

  setUp(() {
    mockCheckPhone = MockCheckPhoneUseCase();
    mockSendCode = MockSendCodeUseCase();
    mockVerifyCode = MockVerifyCodeUseCase();
    mockRegister = MockRegisterUseCase();
    mockLogin = MockLoginUseCase();
    container = ProviderContainer(
      overrides: [
        checkPhoneUseCaseProvider.overrideWithValue(mockCheckPhone),
        sendCodeUseCaseProvider.overrideWithValue(mockSendCode),
        verifyCodeUseCaseProvider.overrideWithValue(mockVerifyCode),
        registerUseCaseProvider.overrideWithValue(mockRegister),
        loginUseCaseProvider.overrideWithValue(mockLogin),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('SignUpViewModel - sendCode', () {
    test('성공 시 codeSent가 true가 된다', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => false);
      when(() => mockSendCode(phone: any(named: 'phone')))
          .thenAnswer((_) async => DateTime(2026, 4, 7));

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.sendCode(phone: '01012345678');

      final state = container.read(signUpViewModelProvider);
      expect(state.isSendingCode, false);
      expect(state.codeSent, true);
      expect(state.error, isNull);
    });

    test('이미 가입된 번호이면 에러를 throw하고 인증코드를 보내지 않는다', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => true);

      final notifier = container.read(signUpViewModelProvider.notifier);

      try {
        await notifier.sendCode(phone: '01012345678');
        fail('예외가 발생해야 합니다');
      } catch (e) {
        expect(e, isA<AppError>());
        expect((e as AppError).message, contains('이미 가입된'));
      }

      final state = container.read(signUpViewModelProvider);
      expect(state.codeSent, false);
      expect(state.error, contains('이미 가입된'));
      verifyNever(() => mockSendCode(phone: any(named: 'phone')));
    });

    test('실패 시 AppError를 throw한다', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => false);
      when(() => mockSendCode(phone: any(named: 'phone')))
          .thenThrow(Exception('발송 실패'));

      final notifier = container.read(signUpViewModelProvider.notifier);

      expect(
        () => notifier.sendCode(phone: '010'),
        throwsA(isA<AppError>()),
      );
    });

    test('DioException 400 INVALID_PHONE_FORMAT 시 친절한 메시지로 변환된다', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => false);
      when(() => mockSendCode(phone: any(named: 'phone'))).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(),
            data: {'code': 'INVALID_PHONE_FORMAT', 'message': '전화번호 형식이 올바르지 않습니다'},
          ),
        ),
      );

      final notifier = container.read(signUpViewModelProvider.notifier);

      try {
        await notifier.sendCode(phone: '010');
        fail('예외가 발생해야 합니다');
      } catch (e) {
        expect(e, isA<AppError>());
        expect((e as AppError).message, contains('전화번호 형식'));
      }
    });

    test('DioException 429 RESEND_COOLDOWN 시 재시도 안내 메시지', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => false);
      when(() => mockSendCode(phone: any(named: 'phone'))).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: 429,
            requestOptions: RequestOptions(),
            data: {'code': 'RESEND_COOLDOWN', 'message': '재발송 대기'},
          ),
        ),
      );

      final notifier = container.read(signUpViewModelProvider.notifier);

      try {
        await notifier.sendCode(phone: '01012345678');
        fail('예외가 발생해야 합니다');
      } catch (e) {
        expect(e, isA<AppError>());
        expect((e as AppError).message, contains('잠시 후'));
      }
    });
  });

  group('SignUpViewModel - verifyCode', () {
    test('성공 시 codeVerified가 true가 된다', () async {
      when(() => mockVerifyCode(
            phone: any(named: 'phone'),
            verificationCode: any(named: 'verificationCode'),
          )).thenAnswer((_) async {});

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.verifyCode(phone: '01012345678', code: '123456');

      final state = container.read(signUpViewModelProvider);
      expect(state.isVerifyingCode, false);
      expect(state.codeVerified, true);
      expect(state.error, isNull);
    });

    test('실패 시 AppError를 throw한다', () async {
      when(() => mockVerifyCode(
            phone: any(named: 'phone'),
            verificationCode: any(named: 'verificationCode'),
          )).thenThrow(Exception('코드 불일치'));

      final notifier = container.read(signUpViewModelProvider.notifier);

      expect(
        () => notifier.verifyCode(phone: '010', code: '000000'),
        throwsA(isA<AppError>()),
      );
    });

    test('CODE_MISMATCH 시 인증코드 불일치 안내', () async {
      when(() => mockVerifyCode(
            phone: any(named: 'phone'),
            verificationCode: any(named: 'verificationCode'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(),
        response: Response(
          statusCode: 400,
          requestOptions: RequestOptions(),
          data: {'code': 'CODE_MISMATCH', 'message': '인증 코드 불일치'},
        ),
      ));

      final notifier = container.read(signUpViewModelProvider.notifier);

      try {
        await notifier.verifyCode(phone: '01012345678', code: '000000');
        fail('예외가 발생해야 합니다');
      } catch (e) {
        expect(e, isA<AppError>());
        expect((e as AppError).message, contains('일치하지 않아요'));
      }
    });
  });

  group('SignUpViewModel - register', () {
    test('성공 시 registered가 true가 되고 자동 로그인된다', () async {
      when(() => mockRegister(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenAnswer((_) async => testUser);
      when(() => mockLogin(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testLoginResult);

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.register(
        phone: '01012345678',
        password: 'pw123456',
        role: 'SUBJECT',
      );

      final state = container.read(signUpViewModelProvider);
      expect(state.isRegistering, false);
      expect(state.registered, true);
      expect(state.error, isNull);
      verify(() => mockLogin(phone: '01012345678', password: 'pw123456'))
          .called(1);
    });

    test('자동 로그인 실패 시 AppError를 throw한다', () async {
      when(() => mockRegister(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenAnswer((_) async => testUser);
      when(() => mockLogin(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenThrow(Exception('로그인 실패'));

      final notifier = container.read(signUpViewModelProvider.notifier);

      expect(
        () => notifier.register(
          phone: '01012345678',
          password: 'pw123456',
          role: 'SUBJECT',
        ),
        throwsA(isA<AppError>()),
      );
    });

    test('실패 시 AppError를 throw한다', () async {
      when(() => mockRegister(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenThrow(Exception('등록 실패'));

      final notifier = container.read(signUpViewModelProvider.notifier);

      expect(
        () => notifier.register(phone: '010', password: 'pw', role: 'SUBJECT'),
        throwsA(isA<AppError>()),
      );
    });

    test('PHONE_ALREADY_REGISTERED 시 중복 가입 안내', () async {
      when(() => mockRegister(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(),
        response: Response(
          statusCode: 409,
          requestOptions: RequestOptions(),
          data: {'code': 'PHONE_ALREADY_REGISTERED', 'message': '이미 가입된 번호'},
        ),
      ));

      final notifier = container.read(signUpViewModelProvider.notifier);

      try {
        await notifier.register(
          phone: '01012345678',
          password: 'pw123456',
          role: 'SUBJECT',
        );
        fail('예외가 발생해야 합니다');
      } catch (e) {
        expect(e, isA<AppError>());
        expect((e as AppError).message, contains('이미 가입'));
      }
    });
  });
}
