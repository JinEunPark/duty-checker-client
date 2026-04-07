import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_req_model.freezed.dart';
part 'refresh_token_req_model.g.dart';

@freezed
class RefreshTokenReqModel with _$RefreshTokenReqModel {
  const factory RefreshTokenReqModel({
    required String refreshToken,
  }) = _RefreshTokenReqModel;

  factory RefreshTokenReqModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenReqModelFromJson(json);
}
