import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_code_req_model.freezed.dart';
part 'send_code_req_model.g.dart';

@freezed
class SendCodeReqModel with _$SendCodeReqModel {
  const factory SendCodeReqModel({
    required String phone,
  }) = _SendCodeReqModel;

  factory SendCodeReqModel.fromJson(Map<String, dynamic> json) =>
      _$SendCodeReqModelFromJson(json);
}
