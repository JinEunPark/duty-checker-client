import 'package:duty_checker/connection/domain/entity/connection.dart';

abstract interface class ConnectionRepository {
  Future<ConnectionList> getConnections();

  Future<Connection> addConnection({
    required String guardianPhone,
    String? name,
  });

  Future<Connection> updateConnectionName({
    required int id,
    required String name,
  });
}
