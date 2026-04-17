import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String phone,
    required String newPassword,
  }) {
    return _repository.resetPassword(phone: phone, newPassword: newPassword);
  }
}
