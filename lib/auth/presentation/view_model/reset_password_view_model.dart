import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/state/reset_password_state.dart';
import 'package:duty_checker/core/error/app_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_password_view_model.g.dart';

@riverpod
class ResetPasswordViewModel extends _$ResetPasswordViewModel {
  @override
  ResetPasswordState build() => const ResetPasswordState();

  Future<void> sendCode({required String phone}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // 가입된 번호인지 확인
      final checkPhoneUseCase = ref.read(checkPhoneUseCaseProvider);
      final exists = await checkPhoneUseCase(phone: phone);
      if (!exists) {
        const message = '가입되지 않은 전화번호입니다.';
        state = state.copyWith(isLoading: false, error: message);
        throw const AppError(type: AppErrorType.notFound, message: message);
      }

      final useCase = ref.read(sendCodeUseCaseProvider);
      final expiresAt = await useCase(phone: phone);
      state = state.copyWith(
        isLoading: false,
        codeSent: true,
        codeExpiresAt: expiresAt,
      );
    } on AppError {
      rethrow;
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isLoading: false, error: appError.message);
      throw appError;
    }
  }

  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(verifyCodeUseCaseProvider);
      await useCase(phone: phone, verificationCode: code);
      state = state.copyWith(isLoading: false, codeVerified: true);
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isLoading: false, error: appError.message);
      throw appError;
    }
  }

  Future<void> resetPassword({
    required String phone,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: 백엔드 API 추가 후 연동 (POST /v1/auth/reset-password)
      // final useCase = ref.read(resetPasswordUseCaseProvider);
      // await useCase(phone: phone, newPassword: newPassword);
      state = state.copyWith(isLoading: false, passwordReset: true);
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isLoading: false, error: appError.message);
      throw appError;
    }
  }
}
