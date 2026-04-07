import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class SendCodeUseCase {
  SendCodeUseCase(this._repository);

  final AuthRepository _repository;

  Future<DateTime> call({required String phone}) {
    return _repository.sendCode(phone: phone);
  }
}
