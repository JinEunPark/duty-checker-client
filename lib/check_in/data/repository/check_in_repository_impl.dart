import 'package:duty_checker/check_in/data/datasource/check_in_remote_datasource.dart';
import 'package:duty_checker/check_in/data/model/create_check_in_resp_model.dart';
import 'package:duty_checker/check_in/data/model/get_latest_check_in_resp_model.dart';
import 'package:duty_checker/check_in/domain/entity/check_in.dart';
import 'package:duty_checker/check_in/domain/repository/check_in_repository.dart';
import 'package:duty_checker/core/date_time_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkInRepositoryProvider = Provider<CheckInRepository>((ref) {
  return CheckInRepositoryImpl(ref.watch(checkInRemoteDataSourceProvider));
});

class CheckInRepositoryImpl implements CheckInRepository {
  CheckInRepositoryImpl(this._remoteDataSource);

  final CheckInRemoteDataSource _remoteDataSource;

  @override
  Future<CheckIn> createCheckIn() async {
    final resp = await _remoteDataSource.createCheckIn();
    return resp.toDomain();
  }

  @override
  Future<LatestCheckIn> getLatestCheckIn() async {
    final resp = await _remoteDataSource.getLatestCheckIn();
    return resp.toDomain();
  }
}

// ── DTO → Entity 변환 ──

extension CreateCheckInRespModelMapper on CreateCheckInRespModel {
  CheckIn toDomain() => CheckIn(
        id: id ?? 0,
        checkedAt: parseServerDateTime(checkedAt) ?? DateTime.now(),
        status: status ?? '',
      );
}

extension GetLatestCheckInRespModelMapper on GetLatestCheckInRespModel {
  LatestCheckIn toDomain() => LatestCheckIn(
        latestCheckedAt: parseServerDateTime(latestCheckedAt),
        todayChecked: todayChecked ?? false,
      );
}
