import 'package:duty_checker/connection/data/datasource/connection_remote_datasource.dart';
import 'package:duty_checker/connection/data/model/connection_resp_model.dart';
import 'package:duty_checker/connection/data/model/get_connections_resp_model.dart';
import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/repository/connection_repository.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectionRepositoryProvider = Provider<ConnectionRepository>((ref) {
  return ConnectionRepositoryImpl(ref.watch(connectionRemoteDataSourceProvider));
});

class ConnectionRepositoryImpl implements ConnectionRepository {
  ConnectionRepositoryImpl(this._remoteDataSource);

  final ConnectionRemoteDataSource _remoteDataSource;

  @override
  Future<ConnectionList> getConnections() async {
    final resp = await _remoteDataSource.getConnections();
    return resp.toDomain();
  }

  @override
  Future<Connection> addConnection({
    required String targetPhone,
    String? name,
  }) async {
    final resp = await _remoteDataSource.addConnection(
      targetPhone: targetPhone,
      name: name,
    );
    return resp.toDomain();
  }

  @override
  Future<Connection> updateConnectionName({
    required int id,
    required String name,
  }) async {
    final resp = await _remoteDataSource.updateConnectionName(
      id: id,
      name: name,
    );
    return resp.toDomain();
  }

  @override
  Future<void> acceptConnection({required int id}) {
    return _remoteDataSource.updateConnectionStatus(
      id: id,
      status: 'CONNECTED',
    );
  }

  @override
  Future<void> rejectConnection({required int id}) {
    return _remoteDataSource.updateConnectionStatus(
      id: id,
      status: 'REJECTED',
    );
  }

  @override
  Future<void> deleteConnection({required int id}) {
    return _remoteDataSource.deleteConnection(id: id);
  }
}

// ── DTO → Entity 변환 ──

extension GetConnectionsRespModelMapper on GetConnectionsRespModel {
  ConnectionList toDomain() => ConnectionList(
        role: UserRoleMapper.fromString(role),
        connections: connections?.map((e) => e.toDomain()).toList() ?? [],
      );
}
