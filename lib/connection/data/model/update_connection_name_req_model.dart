import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_connection_name_req_model.freezed.dart';
part 'update_connection_name_req_model.g.dart';

@freezed
class UpdateConnectionNameReqModel with _$UpdateConnectionNameReqModel {
  const factory UpdateConnectionNameReqModel({
    required String name,
  }) = _UpdateConnectionNameReqModel;

  factory UpdateConnectionNameReqModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateConnectionNameReqModelFromJson(json);
}