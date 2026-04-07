import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:duty_checker/auth/domain/entity/auth_token.dart';

part 'refresh_token_resp_model.freezed.dart';
part 'refresh_token_resp_model.g.dart';

@freezed
class RefreshTokenRespModel with _$RefreshTokenRespModel {
  const factory RefreshTokenRespModel({
    String? accessToken,
    String? refreshToken,
  }) = _RefreshTokenRespModel;

  factory RefreshTokenRespModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRespModelFromJson(json);
}

extension RefreshTokenRespModelMapper on RefreshTokenRespModel {
  AuthToken toDomain() => AuthToken(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
      );
}
