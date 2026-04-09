import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/repository/connection_repository.dart';

class UpdateConnectionNameUseCase {
  UpdateConnectionNameUseCase(this._repository);

  final ConnectionRepository _repository;

  Future<Connection> call({
    required int id,
    required String name,
  }) {
    return _repository.updateConnectionName(id: id, name: name);
  }
}
