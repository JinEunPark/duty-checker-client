import 'package:duty_checker/auth/domain/entity/auth_token.dart';
import 'package:duty_checker/auth/domain/repository/auth_repository.dart';

class RefreshTokenUseCase {
  RefreshTokenUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthToken> call({required String refreshToken}) {
    return _repository.refresh(refreshToken: refreshToken);
  }
}
