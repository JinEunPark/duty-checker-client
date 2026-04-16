import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/repository/connection_repository.dart';

class AddConnectionUseCase {
  AddConnectionUseCase(this._repository);

  final ConnectionRepository _repository;

  Future<Connection> call({
    required String targetPhone,
    String? name,
  }) {
    return _repository.addConnection(
      targetPhone: targetPhone,
      name: name,
    );
  }
}
