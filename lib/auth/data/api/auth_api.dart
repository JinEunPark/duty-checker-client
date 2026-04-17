import 'package:dio/dio.dart';
import 'package:duty_checker/auth/data/model/check_phone_resp_model.dart';
import 'package:duty_checker/auth/data/model/login_req_model.dart';
import 'package:duty_checker/auth/data/model/login_resp_model.dart';
import 'package:duty_checker/auth/data/model/refresh_token_req_model.dart';
import 'package:duty_checker/auth/data/model/refresh_token_resp_model.dart';
import 'package:duty_checker/auth/data/model/register_req_model.dart';
import 'package:duty_checker/auth/data/model/register_resp_model.dart';
import 'package:duty_checker/auth/data/model/send_code_req_model.dart';
import 'package:duty_checker/auth/data/model/send_code_resp_model.dart';
import 'package:duty_checker/auth/data/model/reset_password_req_model.dart';
import 'package:duty_checker/auth/data/model/verify_code_req_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/v1/auth/login')
  Future<LoginRespModel> login(@Body() LoginReqModel body);

  @POST('/v1/auth/register')
  Future<RegisterRespModel> register(@Body() RegisterReqModel body);

  @POST('/v1/auth/send-code')
  Future<SendCodeRespModel> sendCode(@Body() SendCodeReqModel body);

  @POST('/v1/auth/verify-code')
  Future<void> verifyCode(@Body() VerifyCodeReqModel body);

  @POST('/v1/auth/refresh')
  Future<RefreshTokenRespModel> refresh(@Body() RefreshTokenReqModel body);

  @POST('/v1/users/logout')
  Future<void> logout();

  @GET('/v1/auth/check-phone')
  Future<CheckPhoneRespModel> checkPhone(@Query('phone') String phone);

  @PATCH('/v1/auth/password')
  Future<void> resetPassword(@Body() ResetPasswordReqModel body);
}
