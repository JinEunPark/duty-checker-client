import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class VerifyCodeUseCase {
  VerifyCodeUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String phone,
    required String verificationCode,
  }) {
    return _repository.verifyCode(
      phone: phone,
      verificationCode: verificationCode,
    );
  }
}
