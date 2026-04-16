import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_connection_status_req_model.freezed.dart';
part 'update_connection_status_req_model.g.dart';

@freezed
class UpdateConnectionStatusReqModel with _$UpdateConnectionStatusReqModel {
  const factory UpdateConnectionStatusReqModel({
    required String status,
  }) = _UpdateConnectionStatusReqModel;

  factory UpdateConnectionStatusReqModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateConnectionStatusReqModelFromJson(json);
}
