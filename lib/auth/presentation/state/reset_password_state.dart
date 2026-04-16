import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    @Default(false) bool isLoading,
    @Default(false) bool codeSent,
    DateTime? codeExpiresAt,
    @Default(false) bool codeVerified,
    @Default(false) bool passwordReset,
    String? error,
  }) = _ResetPasswordState;
}
