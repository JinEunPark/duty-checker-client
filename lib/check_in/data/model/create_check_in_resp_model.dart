import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_check_in_resp_model.freezed.dart';
part 'create_check_in_resp_model.g.dart';

@freezed
class CreateCheckInRespModel with _$CreateCheckInRespModel {
  const factory CreateCheckInRespModel({
    int? id,
    String? checkedAt,
    String? status,
  }) = _CreateCheckInRespModel;

  factory CreateCheckInRespModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckInRespModelFromJson(json);
}
