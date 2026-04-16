import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_phone_resp_model.freezed.dart';
part 'check_phone_resp_model.g.dart';

@freezed
class CheckPhoneRespModel with _$CheckPhoneRespModel {
  const factory CheckPhoneRespModel({
    @Default(false) bool exists,
  }) = _CheckPhoneRespModel;

  factory CheckPhoneRespModel.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneRespModelFromJson(json);
}
