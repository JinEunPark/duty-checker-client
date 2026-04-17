// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionRespModelImpl _$$ConnectionRespModelImplFromJson(
  Map<String, dynamic> json,
) => _$ConnectionRespModelImpl(
  id: (json['id'] as num?)?.toInt(),
  phone: json['phone'] as String?,
  name: json['name'] as String?,
  status: json['status'] as String?,
  latestCheckedAt: json['latestCheckedAt'] as String?,
  isTodayChecked: json['isTodayChecked'] as bool?,
  requesterRole: json['requesterRole'] as String?,
);

Map<String, dynamic> _$$ConnectionRespModelImplToJson(
  _$ConnectionRespModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'phone': instance.phone,
  'name': instance.name,
  'status': instance.status,
  'latestCheckedAt': instance.latestCheckedAt,
  'isTodayChecked': instance.isTodayChecked,
  'requesterRole': instance.requesterRole,
};
