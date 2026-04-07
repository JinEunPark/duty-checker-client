import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool isSendingCode,
    @Default(false) bool isVerifyingCode,
    @Default(false) bool isRegistering,
    @Default(false) bool codeSent,
    DateTime? codeExpiresAt,
    @Default(false) bool codeVerified,
    @Default(false) bool registered,
    User? user,
    String? error,
  }) = _SignUpState;
}
