import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:duty_checker/auth/domain/entity/auth_token.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';

part 'login_result.freezed.dart';

@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult({
    required AuthToken token,
    required User user,
  }) = _LoginResult;
}
