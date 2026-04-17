import 'package:duty_checker/auth/domain/entity/auth_token.dart';
import 'package:duty_checker/auth/domain/entity/login_result.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';

abstract interface class AuthRepository {
  Future<LoginResult> login({
    required String phone,
    required String password,
  });

  Future<User> register({
    required String phone,
    required String password,
    required String role,
  });

  Future<DateTime> sendCode({required String phone});

  Future<void> verifyCode({
    required String phone,
    required String verificationCode,
  });

  Future<AuthToken> refresh({required String refreshToken});

  Future<void> logout();

  Future<bool> checkPhone({required String phone});

  Future<void> resetPassword({
    required String phone,
    required String newPassword,
  });
}
