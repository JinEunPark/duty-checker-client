import 'package:duty_checker/core/network/dio_provider.dart';
import 'package:duty_checker/user/data/api/user_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSource(UserApi(ref.watch(dioProvider)));
});

class UserRemoteDataSource {
  UserRemoteDataSource(this._api);

  final UserApi _api;

  Future<void> deleteAccount() => _api.deleteAccount();
}
