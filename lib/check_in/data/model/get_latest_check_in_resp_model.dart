import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_latest_check_in_resp_model.freezed.dart';
part 'get_latest_check_in_resp_model.g.dart';

@freezed
class GetLatestCheckInRespModel with _$GetLatestCheckInRespModel {
  const factory GetLatestCheckInRespModel({
    String? latestCheckedAt,
    bool? todayChecked,
  }) = _GetLatestCheckInRespModel;

  factory GetLatestCheckInRespModel.fromJson(Map<String, dynamic> json) =>
      _$GetLatestCheckInRespModelFromJson(json);
}
