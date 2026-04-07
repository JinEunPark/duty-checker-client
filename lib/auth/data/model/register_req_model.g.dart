// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterReqModelImpl _$$RegisterReqModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterReqModelImpl(
      phone: json['phone'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$RegisterReqModelImplToJson(
        _$RegisterReqModelImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
      'role': instance.role,
    };
