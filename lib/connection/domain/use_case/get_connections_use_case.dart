import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/repository/connection_repository.dart';

class GetConnectionsUseCase {
  GetConnectionsUseCase(this._repository);

  final ConnectionRepository _repository;

  Future<ConnectionList> call() {
    return _repository.getConnections();
  }
}
