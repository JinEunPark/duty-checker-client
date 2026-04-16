import 'package:duty_checker/connection/domain/entity/connection.dart';

abstract interface class ConnectionRepository {
  Future<ConnectionList> getConnections();

  Future<Connection> addConnection({
    required String targetPhone,
    String? name,
  });

  Future<Connection> updateConnectionName({
    required int id,
    required String name,
  });

  Future<void> acceptConnection({required int id});

  Future<void> rejectConnection({required int id});

  Future<void> deleteConnection({required int id});
}
