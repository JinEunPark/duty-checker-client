import 'package:duty_checker/connection/domain/repository/connection_repository.dart';

class AcceptConnectionUseCase {
  AcceptConnectionUseCase(this._repository);

  final ConnectionRepository _repository;

  Future<void> call({required int id}) {
    return _repository.acceptConnection(id: id);
  }
}
