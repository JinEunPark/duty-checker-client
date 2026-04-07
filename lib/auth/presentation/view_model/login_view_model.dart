import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/state/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState();

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(loginUseCaseProvider);
      final result = await useCase(phone: phone, password: password);
      state = state.copyWith(isLoading: false, user: result.user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
