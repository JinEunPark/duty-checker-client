import 'package:duty_checker/core/date_time_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/connection.dart';

part 'connection_resp_model.freezed.dart';
part 'connection_resp_model.g.dart';

@freezed
class ConnectionRespModel with _$ConnectionRespModel {
  const factory ConnectionRespModel({
    int? id,
    String? phone,
    String? name,
    String? status,
    String? latestCheckedAt,
    bool? isTodayChecked,
  }) = _ConnectionRespModel;

  factory ConnectionRespModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectionRespModelFromJson(json);
}

extension ConnectionRespModelMapper on ConnectionRespModel {
  Connection toDomain() => Connection(
        id: id ?? 0,
        phone: phone ?? '',
        name: name ?? '',
        status: ConnectionStatusMapper.fromString(status),
        latestCheckedAt: parseServerDateTime(latestCheckedAt),
        isTodayChecked: isTodayChecked ?? false,
      );
}