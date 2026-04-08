import 'package:dio/dio.dart';
import 'package:duty_checker/core/fcm/update_device_token_req_model.dart';
import 'package:retrofit/retrofit.dart';
part 'device_token_api.g.dart';

@RestApi()
abstract class DeviceTokenApi{
  factory DeviceTokenApi(Dio dio) = _DeviceTokenApi;

  @PATCH('/v1/users/device-token')
  Future<void> updateDeviceToken(@Body() UpdateDeviceTokenReqModel body);
}
