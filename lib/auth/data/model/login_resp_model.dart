import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:duty_checker/auth/domain/entity/auth_token.dart';
import 'package:duty_checker/auth/domain/entity/login_result.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';

part 'login_resp_model.freezed.dart';
part 'login_resp_model.g.dart';

@freezed
class LoginRespModel with _$LoginRespModel {
  const factory LoginRespModel({
    String? accessToken,
    String? refreshToken,
    UserInfoModel? user,
  }) = _LoginRespModel;

  factory LoginRespModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRespModelFromJson(json);
}

@freezed
class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    int? id,
    String? phone,
    String? role,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}

extension LoginRespModelMapper on LoginRespModel {
  LoginResult toDomain() => LoginResult(
        token: AuthToken(
          accessToken: accessToken ?? '',
          refreshToken: refreshToken ?? '',
        ),
        user: user!.toDomain(),
      );
}

extension UserInfoModelMapper on UserInfoModel {
  User toDomain() => User(
        id: id ?? 0,
        phone: phone ?? '',
        role: UserRoleMapper.fromString(role),
      );
}
