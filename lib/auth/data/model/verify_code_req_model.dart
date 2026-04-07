import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_code_req_model.freezed.dart';
part 'verify_code_req_model.g.dart';

@freezed
class VerifyCodeReqModel with _$VerifyCodeReqModel {
  const factory VerifyCodeReqModel({
    required String phone,
    required String verificationCode,
  }) = _VerifyCodeReqModel;

  factory VerifyCodeReqModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeReqModelFromJson(json);
}
