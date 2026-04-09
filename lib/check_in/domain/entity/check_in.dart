import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in.freezed.dart';

@freezed
class CheckIn with _$CheckIn {
  const factory CheckIn({
    required int id,
    required DateTime checkedAt,
    required String status,
  }) = _CheckIn;
}

@freezed
class LatestCheckIn with _$LatestCheckIn {
  const factory LatestCheckIn({
    DateTime? latestCheckedAt,
    required bool todayChecked,
  }) = _LatestCheckIn;
}
