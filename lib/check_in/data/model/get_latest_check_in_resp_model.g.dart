// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_latest_check_in_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetLatestCheckInRespModelImpl _$$GetLatestCheckInRespModelImplFromJson(
  Map<String, dynamic> json,
) => _$GetLatestCheckInRespModelImpl(
  latestCheckedAt: json['latestCheckedAt'] as String?,
  todayChecked: json['todayChecked'] as bool?,
);

Map<String, dynamic> _$$GetLatestCheckInRespModelImplToJson(
  _$GetLatestCheckInRespModelImpl instance,
) => <String, dynamic>{
  'latestCheckedAt': instance.latestCheckedAt,
  'todayChecked': instance.todayChecked,
};
