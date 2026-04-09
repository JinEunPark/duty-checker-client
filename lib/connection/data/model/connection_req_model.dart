import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_req_model.freezed.dart';
part 'connection_req_model.g.dart';

@freezed
class ConnectionReqModel with _$ConnectionReqModel {
  const factory ConnectionReqModel({
    required String guardianPhone,
    String? name,
  }) = _ConnectionReqModel;

  factory ConnectionReqModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectionReqModelFromJson(json);
}