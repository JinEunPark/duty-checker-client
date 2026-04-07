// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRespModelImpl _$$LoginRespModelImplFromJson(Map<String, dynamic> json) =>
    _$LoginRespModelImpl(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : UserInfoModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginRespModelImplToJson(
        _$LoginRespModelImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_$UserInfoModelImpl _$$UserInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoModelImpl(
      id: (json['id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$UserInfoModelImplToJson(_$UserInfoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'role': instance.role,
    };
