// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_check_in_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateCheckInRespModelImpl _$$CreateCheckInRespModelImplFromJson(
  Map<String, dynamic> json,
) => _$CreateCheckInRespModelImpl(
  id: (json['id'] as num?)?.toInt(),
  checkedAt: json['checkedAt'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$CreateCheckInRespModelImplToJson(
  _$CreateCheckInRespModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'checkedAt': instance.checkedAt,
  'status': instance.status,
};
