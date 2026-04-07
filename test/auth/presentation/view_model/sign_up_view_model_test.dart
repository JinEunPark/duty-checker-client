import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/view_model/sign_up_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockSendCodeUseCase mockSendCode;
  late MockVerifyCodeUseCase mockVerifyCode;
  late MockRegisterUseCase mockRegister;
  late MockLoginUseCase mockLogin;
  late ProviderContainer container;

  setUp(() {
    mockSendCode = MockSendCodeUseCase();
    mockVerifyCode = MockVerifyCodeUseCase();
    mockRegister = MockRegisterUseCase();
    mockLogin = MockLoginUseCase();
    container = ProviderContainer(
      overrides: [
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
      when(() => mockSendCode(phone: any(named: 'phone')))
          .thenAnswer((_) async => DateTime(2026, 4, 7));

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.sendCode(phone: '01012345678');

      final state = container.read(signUpViewModelProvider);
      expect(state.isSendingCode, false);
      expect(state.codeSent, true);
      expect(state.error, isNull);
    });

    test('실패 시 error가 설정된다', () async {
      when(() => mockSendCode(phone: any(named: 'phone')))
          .thenThrow(Exception('발송 실패'));

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.sendCode(phone: '010');

      final state = container.read(signUpViewModelProvider);
      expect(state.isSendingCode, false);
      expect(state.codeSent, false);
      expect(state.error, contains('발송 실패'));
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

    test('실패 시 error가 설정된다', () async {
      when(() => mockVerifyCode(
            phone: any(named: 'phone'),
            verificationCode: any(named: 'verificationCode'),
          )).thenThrow(Exception('코드 불일치'));

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.verifyCode(phone: '010', code: '000000');

      final state = container.read(signUpViewModelProvider);
      expect(state.isVerifyingCode, false);
      expect(state.codeVerified, false);
      expect(state.error, contains('코드 불일치'));
    });
  });

  group('SignUpViewModel - register', () {
    test('성공 시 registered가 true이고 자동 로그인으로 user가 설정된다', () async {
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
      expect(state.user, testUser);
      expect(state.error, isNull);

      verify(() => mockLogin(phone: '01012345678', password: 'pw123456')).called(1);
    });

    test('등록 실패 시 error가 설정되고 로그인은 호출되지 않는다', () async {
      when(() => mockRegister(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenThrow(Exception('이미 가입된 번호'));

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.register(
        phone: '010',
        password: 'pw',
        role: 'SUBJECT',
      );

      final state = container.read(signUpViewModelProvider);
      expect(state.isRegistering, false);
      expect(state.registered, false);
      expect(state.error, contains('이미 가입된 번호'));

      verifyNever(() => mockLogin(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          ));
    });

    test('등록 성공 후 자동 로그인 실패 시 error가 설정된다', () async {
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
      await notifier.register(
        phone: '01012345678',
        password: 'pw123456',
        role: 'SUBJECT',
      );

      final state = container.read(signUpViewModelProvider);
      expect(state.isRegistering, false);
      expect(state.registered, true);
      expect(state.user, isNull);
      expect(state.error, contains('자동 로그인에 실패'));
    });

    test('보호자 가입 성공 시 guardian user가 설정된다', () async {
      when(() => mockRegister(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenAnswer((_) async => testGuardian);
      when(() => mockLogin(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testGuardianLoginResult);

      final notifier = container.read(signUpViewModelProvider.notifier);
      await notifier.register(
        phone: '01087654321',
        password: 'pw123456',
        role: 'GUARDIAN',
      );

      final state = container.read(signUpViewModelProvider);
      expect(state.registered, true);
      expect(state.user, testGuardian);
      expect(state.user!.isGuardian, true);
    });
  });
}
