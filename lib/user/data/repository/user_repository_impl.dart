import 'package:duty_checker/core/network/token_storage.dart';
import 'package:duty_checker/user/data/datasource/user_remote_datasource.dart';
import 'package:duty_checker/user/domain/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    ref.watch(userRemoteDataSourceProvider),
    ref.watch(tokenStorageProvider),
  );
});

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  final UserRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<void> deleteAccount() async {
    try {
      await _remoteDataSource.deleteAccount();
    } finally {
      await _tokenStorage.clear();
    }
  }
}
