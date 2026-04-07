import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<User> call({
    required String phone,
    required String password,
    required String role,
  }) {
    return _repository.register(
      phone: phone,
      password: password,
      role: role,
    );
  }
}
