import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/repository/connection_repository.dart';

class AddConnectionUseCase {
  AddConnectionUseCase(this._repository);

  final ConnectionRepository _repository;

  Future<Connection> call({
    required String guardianPhone,
    String? name,
  }) {
    return _repository.addConnection(
      guardianPhone: guardianPhone,
      name: name,
    );
  }
}
