import 'package:duty_checker/check_in/domain/entity/check_in.dart';

abstract interface class CheckInRepository {
  Future<CheckIn> createCheckIn();
  Future<LatestCheckIn> getLatestCheckIn();
}
