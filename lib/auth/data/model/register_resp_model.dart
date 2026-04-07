import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';

part 'register_resp_model.freezed.dart';
part 'register_resp_model.g.dart';

@freezed
class RegisterRespModel with _$RegisterRespModel {
  const factory RegisterRespModel({
    int? id,
    String? phone,
    String? role,
  }) = _RegisterRespModel;

  factory RegisterRespModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRespModelFromJson(json);
}

extension RegisterRespModelMapper on RegisterRespModel {
  User toDomain() => User(
        id: id ?? 0,
        phone: phone ?? '',
        role: UserRoleMapper.fromString(role),
      );
}
