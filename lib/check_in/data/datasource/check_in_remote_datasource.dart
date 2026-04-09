import 'package:duty_checker/check_in/data/api/check_in_api.dart';
import 'package:duty_checker/check_in/data/model/create_check_in_resp_model.dart';
import 'package:duty_checker/check_in/data/model/get_latest_check_in_resp_model.dart';
import 'package:duty_checker/core/network/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkInRemoteDataSourceProvider =
    Provider<CheckInRemoteDataSource>((ref) {
  return CheckInRemoteDataSource(CheckInApi(ref.watch(dioProvider)));
});

class CheckInRemoteDataSource {
  CheckInRemoteDataSource(this._api);

  final CheckInApi _api;

  Future<CreateCheckInRespModel> createCheckIn() {
    return _api.createCheckIn();
  }

  Future<GetLatestCheckInRespModel> getLatestCheckIn() {
    return _api.getLatestCheckIn();
  }
}
