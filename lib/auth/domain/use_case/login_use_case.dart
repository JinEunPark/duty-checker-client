import 'package:duty_checker/auth/domain/entity/login_result.dart';
import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<LoginResult> call({
    required String phone,
    required String password,
  }) {
    return _repository.login(phone: phone, password: password);
  }
}
