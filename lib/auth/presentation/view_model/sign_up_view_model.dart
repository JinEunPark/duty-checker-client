import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/state/sign_up_state.dart';
import 'package:duty_checker/core/error/app_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_view_model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  @override
  SignUpState build() => const SignUpState();

  Future<void> sendCode({required String phone}) async {
    state = state.copyWith(isSendingCode: true, error: null);
    try {
      // 이미 가입된 번호인지 확인
      final checkPhoneUseCase = ref.read(checkPhoneUseCaseProvider);
      final exists = await checkPhoneUseCase(phone: phone);
      if (exists) {
        const message = '이미 가입된 전화번호입니다. 로그인 화면에서 로그인해주세요.';
        state = state.copyWith(isSendingCode: false, error: message);
        throw AppError(type: AppErrorType.conflict, message: message);
      }

      final useCase = ref.read(sendCodeUseCaseProvider);
      final expiresAt = await useCase(phone: phone);
      state = state.copyWith(
        isSendingCode: false,
        codeSent: true,
        codeExpiresAt: expiresAt,
      );
    } on AppError {
      rethrow;
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isSendingCode: false, error: appError.message);
      throw appError;
    }
  }

  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    state = state.copyWith(isVerifyingCode: true, error: null);
    try {
      final useCase = ref.read(verifyCodeUseCaseProvider);
      await useCase(phone: phone, verificationCode: code);
      state = state.copyWith(isVerifyingCode: false, codeVerified: true);
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isVerifyingCode: false, error: appError.message);
      throw appError;
    }
  }

  Future<void> register({
    required String phone,
    required String password,
    required String role,
  }) async {
    state = state.copyWith(isRegistering: true, error: null);
    try {
      final registerUseCase = ref.read(registerUseCaseProvider);
      await registerUseCase(phone: phone, password: password, role: role);

      // 회원가입 성공 후 자동 로그인 (토큰/role 저장)
      final loginUseCase = ref.read(loginUseCaseProvider);
      await loginUseCase(phone: phone, password: password);

      state = state.copyWith(isRegistering: false, registered: true);
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isRegistering: false, error: appError.message);
      throw appError;
    }
  }
}
