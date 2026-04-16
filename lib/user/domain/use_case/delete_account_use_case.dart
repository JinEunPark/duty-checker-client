import 'package:duty_checker/user/domain/repository/user_repository.dart';

class DeleteAccountUseCase {
  DeleteAccountUseCase(this._repository);

  final UserRepository _repository;

  Future<void> call() {
    return _repository.deleteAccount();
  }
}
