import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/view_model/reset_password_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockCheckPhoneUseCase mockCheckPhone;
  late MockSendCodeUseCase mockSendCode;
  late MockVerifyCodeUseCase mockVerifyCode;
  late MockResetPasswordUseCase mockResetPassword;
  late ProviderContainer container;

  setUp(() {
    mockCheckPhone = MockCheckPhoneUseCase();
    mockSendCode = MockSendCodeUseCase();
    mockVerifyCode = MockVerifyCodeUseCase();
    mockResetPassword = MockResetPasswordUseCase();
    container = ProviderContainer(
      overrides: [
        checkPhoneUseCaseProvider.overrideWithValue(mockCheckPhone),
        sendCodeUseCaseProvider.overrideWithValue(mockSendCode),
        verifyCodeUseCaseProvider.overrideWithValue(mockVerifyCode),
        resetPasswordUseCaseProvider.overrideWithValue(mockResetPassword),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('ResetPasswordViewModel - 초기 상태', () {
    test('초기 상태는 모두 기본값이다', () {
      final state = container.read(resetPasswordViewModelProvider);

      expect(state.isLoading, false);
      expect(state.codeSent, false);
      expect(state.codeVerified, false);
      expect(state.passwordReset, false);
      expect(state.error, isNull);
    });
  });

  group('ResetPasswordViewModel - sendCode', () {
    test('가입된 번호로 인증코드 요청 시 codeSent가 true가 된다', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => true);
      when(() => mockSendCode(phone: any(named: 'phone')))
          .thenAnswer((_) async => DateTime(2026, 4, 17));

      final notifier = container.read(resetPasswordViewModelProvider.notifier);
      await notifier.sendCode(phone: '01012345678');

      final state = container.read(resetPasswordViewModelProvider);
      expect(state.isLoading, false);
      expect(state.codeSent, true);
      expect(state.codeExpiresAt, DateTime(2026, 4, 17));
      expect(state.error, isNull);
    });

    test('미가입 번호로 요청 시 에러가 설정된다', () async {
      when(() => mockCheckPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => false);

      final notifier = container.read(resetPasswordViewModelProvider.notifier);

      expect(
        () => notifier.sendCode(phone: '01099998888'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('ResetPasswordViewModel - verifyCode', () {
    test('성공 시 codeVerified가 true가 된다', () async {
      when(() => mockVerifyCode(
            phone: any(named: 'phone'),
            verificationCode: any(named: 'verificationCode'),
          )).thenAnswer((_) async {});

      final notifier = container.read(resetPasswordViewModelProvider.notifier);
      await notifier.verifyCode(phone: '01012345678', code: '123456');

      final state = container.read(resetPasswordViewModelProvider);
      expect(state.isLoading, false);
      expect(state.codeVerified, true);
      expect(state.error, isNull);
    });

    test('실패 시 error가 설정된다', () async {
      when(() => mockVerifyCode(
            phone: any(named: 'phone'),
            verificationCode: any(named: 'verificationCode'),
          )).thenThrow(Exception('잘못된 인증코드'));

      final notifier = container.read(resetPasswordViewModelProvider.notifier);
      try {
        await notifier.verifyCode(phone: '01012345678', code: '000000');
      } catch (_) {}

      final state = container.read(resetPasswordViewModelProvider);
      expect(state.isLoading, false);
      expect(state.codeVerified, false);
      expect(state.error, isNotNull);
    });
  });

  group('ResetPasswordViewModel - resetPassword', () {
    test('성공 시 passwordReset이 true가 된다', () async {
      when(() => mockResetPassword(
            phone: any(named: 'phone'),
            newPassword: any(named: 'newPassword'),
          )).thenAnswer((_) async {});

      final notifier = container.read(resetPasswordViewModelProvider.notifier);
      await notifier.resetPassword(
        phone: '01012345678',
        newPassword: 'newPw123',
      );

      final state = container.read(resetPasswordViewModelProvider);
      expect(state.isLoading, false);
      expect(state.passwordReset, true);
      expect(state.error, isNull);

      verify(() => mockResetPassword(
            phone: '01012345678',
            newPassword: 'newPw123',
          )).called(1);
    });

    test('실패 시 error가 설정된다', () async {
      when(() => mockResetPassword(
            phone: any(named: 'phone'),
            newPassword: any(named: 'newPassword'),
          )).thenThrow(Exception('서버 오류'));

      final notifier = container.read(resetPasswordViewModelProvider.notifier);
      try {
        await notifier.resetPassword(
          phone: '01012345678',
          newPassword: 'newPw123',
        );
      } catch (_) {}

      final state = container.read(resetPasswordViewModelProvider);
      expect(state.isLoading, false);
      expect(state.passwordReset, false);
      expect(state.error, isNotNull);
    });
  });
}
