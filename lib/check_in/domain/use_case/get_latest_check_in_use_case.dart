import 'package:duty_checker/check_in/domain/entity/check_in.dart';
import 'package:duty_checker/check_in/domain/repository/check_in_repository.dart';

class GetLatestCheckInUseCase {
  GetLatestCheckInUseCase(this._repository);

  final CheckInRepository _repository;

  Future<LatestCheckIn> call() {
    return _repository.getLatestCheckIn();
  }
}
