// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRespModelImpl _$$RegisterRespModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRespModelImpl(
      id: (json['id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$RegisterRespModelImplToJson(
        _$RegisterRespModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'role': instance.role,
    };
