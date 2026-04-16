import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class CheckPhoneUseCase {
  CheckPhoneUseCase(this._repository);

  final AuthRepository _repository;

  /// Returns true if the phone number is already registered.
  Future<bool> call({required String phone}) {
    return _repository.checkPhone(phone: phone);
  }
}
