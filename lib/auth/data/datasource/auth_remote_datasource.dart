import 'package:duty_checker/auth/data/api/auth_api.dart';
import 'package:duty_checker/auth/data/model/login_req_model.dart';
import 'package:duty_checker/auth/data/model/login_resp_model.dart';
import 'package:duty_checker/auth/data/model/refresh_token_req_model.dart';
import 'package:duty_checker/auth/data/model/refresh_token_resp_model.dart';
import 'package:duty_checker/auth/data/model/register_req_model.dart';
import 'package:duty_checker/auth/data/model/register_resp_model.dart';
import 'package:duty_checker/auth/data/model/send_code_req_model.dart';
import 'package:duty_checker/auth/data/model/send_code_resp_model.dart';
import 'package:duty_checker/auth/data/model/verify_code_req_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:duty_checker/core/network/dio_provider.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(AuthApi(ref.watch(dioProvider)));
});

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._api);

  final AuthApi _api;

  Future<LoginRespModel> login({
    required String phone,
    required String password,
  }) {
    return _api.login(LoginReqModel(phone: phone, password: password));
  }

  Future<RegisterRespModel> register({
    required String phone,
    required String password,
    required String role,
  }) {
    return _api.register(
      RegisterReqModel(phone: phone, password: password, role: role),
    );
  }

  Future<SendCodeRespModel> sendCode({required String phone}) {
    return _api.sendCode(SendCodeReqModel(phone: phone));
  }

  Future<void> verifyCode({
    required String phone,
    required String verificationCode,
  }) {
    return _api.verifyCode(
      VerifyCodeReqModel(phone: phone, verificationCode: verificationCode),
    );
  }

  Future<RefreshTokenRespModel> refresh({required String refreshToken}) {
    return _api.refresh(RefreshTokenReqModel(refreshToken: refreshToken));
  }

  Future<void> logout() => _api.logout();

  Future<bool> checkPhone({required String phone}) async {
    final resp = await _api.checkPhone(phone);
    return resp.exists;
  }
}
