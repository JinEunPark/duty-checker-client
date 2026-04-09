import 'package:duty_checker/auth/data/datasource/auth_remote_datasource.dart';
import 'package:duty_checker/auth/data/model/login_resp_model.dart';
import 'package:duty_checker/auth/data/model/refresh_token_resp_model.dart';
import 'package:duty_checker/auth/data/model/register_resp_model.dart';
import 'package:duty_checker/auth/domain/entity/auth_token.dart';
import 'package:duty_checker/auth/domain/entity/login_result.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:duty_checker/auth/domain/repository/auth_repository.dart';
import 'package:duty_checker/core/date_time_utils.dart';
import 'package:duty_checker/core/network/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(tokenStorageProvider),
  );
});

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<LoginResult> login({
    required String phone,
    required String password,
  }) async {
    final resp = await _remoteDataSource.login(
      phone: phone,
      password: password,
    );
    final result = resp.toDomain();
    await _tokenStorage.saveTokens(
      accessToken: result.token.accessToken,
      refreshToken: result.token.refreshToken,
    );
    await _tokenStorage.saveRole(result.user.role.name.toUpperCase());
    return result;
  }

  @override
  Future<User> register({
    required String phone,
    required String password,
    required String role,
  }) async {
    final resp = await _remoteDataSource.register(
      phone: phone,
      password: password,
      role: role,
    );
    return resp.toDomain();
  }

  @override
  Future<DateTime> sendCode({required String phone}) async {
    final resp = await _remoteDataSource.sendCode(phone: phone);
    return parseServerDateTime(resp.expiredAt) ?? DateTime.now();
  }

  @override
  Future<void> verifyCode({
    required String phone,
    required String verificationCode,
  }) {
    return _remoteDataSource.verifyCode(
      phone: phone,
      verificationCode: verificationCode,
    );
  }

  @override
  Future<AuthToken> refresh({required String refreshToken}) async {
    final resp = await _remoteDataSource.refresh(
      refreshToken: refreshToken,
    );
    final token = resp.toDomain();
    await _tokenStorage.saveTokens(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    );
    return token;
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } finally {
      await _tokenStorage.clear();
    }
  }
}
