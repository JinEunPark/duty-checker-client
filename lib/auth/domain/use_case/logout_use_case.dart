import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() {
    return _repository.logout();
  }
}
