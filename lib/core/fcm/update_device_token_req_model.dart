import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_device_token_req_model.g.dart';
part 'update_device_token_req_model.freezed.dart';
@freezed
class UpdateDeviceTokenReqModel with _$UpdateDeviceTokenReqModel{
  const factory UpdateDeviceTokenReqModel({
    required String fcmToken,
  }) = _UpdateDeviceTokenReqModel;


  factory UpdateDeviceTokenReqModel.fromJson(Map<String, dynamic> json) => _$UpdateDeviceTokenReqModelFromJson(json);
}
