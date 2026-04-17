import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_req_model.freezed.dart';
part 'reset_password_req_model.g.dart';

@freezed
class ResetPasswordReqModel with _$ResetPasswordReqModel {
  const factory ResetPasswordReqModel({
    required String phone,
    required String newPassword,
  }) = _ResetPasswordReqModel;

  factory ResetPasswordReqModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordReqModelFromJson(json);
}
