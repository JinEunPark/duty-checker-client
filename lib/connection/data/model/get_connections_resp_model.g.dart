// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_connections_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetConnectionsRespModelImpl _$$GetConnectionsRespModelImplFromJson(
  Map<String, dynamic> json,
) => _$GetConnectionsRespModelImpl(
  role: json['role'] as String?,
  connections: (json['connections'] as List<dynamic>?)
      ?.map((e) => ConnectionRespModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$GetConnectionsRespModelImplToJson(
  _$GetConnectionsRespModelImpl instance,
) => <String, dynamic>{
  'role': instance.role,
  'connections': instance.connections,
};
