import 'package:duty_checker/auth/data/repository/auth_repository_impl.dart';
import 'package:duty_checker/auth/domain/use_case/check_phone_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/login_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/logout_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/refresh_token_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/register_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/send_code_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/verify_code_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final sendCodeUseCaseProvider = Provider<SendCodeUseCase>((ref) {
  return SendCodeUseCase(ref.watch(authRepositoryProvider));
});

final verifyCodeUseCaseProvider = Provider<VerifyCodeUseCase>((ref) {
  return VerifyCodeUseCase(ref.watch(authRepositoryProvider));
});

final refreshTokenUseCaseProvider = Provider<RefreshTokenUseCase>((ref) {
  return RefreshTokenUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final checkPhoneUseCaseProvider = Provider<CheckPhoneUseCase>((ref) {
  return CheckPhoneUseCase(ref.watch(authRepositoryProvider));
});
