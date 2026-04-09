import 'package:duty_checker/connection/data/api/connection_api.dart';
import 'package:duty_checker/connection/data/model/connection_req_model.dart';
import 'package:duty_checker/connection/data/model/connection_resp_model.dart';
import 'package:duty_checker/connection/data/model/get_connections_resp_model.dart';
import 'package:duty_checker/connection/data/model/update_connection_name_req_model.dart';
import 'package:duty_checker/core/network/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectionRemoteDataSourceProvider =
    Provider<ConnectionRemoteDataSource>((ref) {
  return ConnectionRemoteDataSource(ConnectionApi(ref.watch(dioProvider)));
});

class ConnectionRemoteDataSource {
  ConnectionRemoteDataSource(this._api);

  final ConnectionApi _api;

  Future<GetConnectionsRespModel> getConnections() {
    return _api.getConnections();
  }

  Future<ConnectionRespModel> addConnection({
    required String guardianPhone,
    String? name,
  }) {
    return _api.addConnection(
      ConnectionReqModel(guardianPhone: guardianPhone, name: name),
    );
  }

  Future<ConnectionRespModel> updateConnectionName({
    required int id,
    required String name,
  }) {
    return _api.updateConnectionName(
      id,
      UpdateConnectionNameReqModel(name: name),
    );
  }
}
