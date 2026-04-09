import 'package:freezed_annotation/freezed_annotation.dart';

import 'connection_resp_model.dart';

part 'get_connections_resp_model.freezed.dart';
part 'get_connections_resp_model.g.dart';

@freezed
class GetConnectionsRespModel with _$GetConnectionsRespModel {
  const factory GetConnectionsRespModel({
    String? role,
    List<ConnectionRespModel>? connections,
  }) = _GetConnectionsRespModel;

  factory GetConnectionsRespModel.fromJson(Map<String, dynamic> json) =>
      _$GetConnectionsRespModelFromJson(json);
}