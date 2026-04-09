import 'package:duty_checker/check_in/domain/entity/check_in.dart';
import 'package:duty_checker/check_in/domain/repository/check_in_repository.dart';

class CreateCheckInUseCase {
  CreateCheckInUseCase(this._repository);

  final CheckInRepository _repository;

  Future<CheckIn> call() {
    return _repository.createCheckIn();
  }
}
