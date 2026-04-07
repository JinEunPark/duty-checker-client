import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    String? error,
    User? user,
  }) = _LoginState;
}
