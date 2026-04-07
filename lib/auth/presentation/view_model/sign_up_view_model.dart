import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/state/sign_up_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_view_model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  @override
  SignUpState build() => const SignUpState();

  Future<void> sendCode({required String phone}) async {
    state = state.copyWith(isSendingCode: true, error: null);
    try {
      final useCase = ref.read(sendCodeUseCaseProvider);
      await useCase(phone: phone);
      state = state.copyWith(isSendingCode: false, codeSent: true);
    } catch (e) {
      state = state.copyWith(isSendingCode: false, error: e.toString());
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
      state = state.copyWith(isVerifyingCode: false, error: e.toString());
    }
  }

  Future<void> register({
    required String phone,
    required String password,
    required String role,
  }) async {
    state = state.copyWith(isRegistering: true, error: null);
    try {
      final useCase = ref.read(registerUseCaseProvider);
      await useCase(phone: phone, password: password, role: role);
      state = state.copyWith(isRegistering: false, registered: true);
    } catch (e) {
      state = state.copyWith(isRegistering: false, error: e.toString());
    }
  }
}
