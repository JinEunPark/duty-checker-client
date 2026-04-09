import 'package:dio/dio.dart';
import 'package:duty_checker/check_in/data/model/create_check_in_resp_model.dart';
import 'package:duty_checker/check_in/data/model/get_latest_check_in_resp_model.dart';
import 'package:retrofit/retrofit.dart';

part 'check_in_api.g.dart';

@RestApi()
abstract class CheckInApi {
  factory CheckInApi(Dio dio, {String baseUrl}) = _CheckInApi;

  @POST('/v1/check-ins')
  Future<CreateCheckInRespModel> createCheckIn();

  @GET('/v1/check-ins/latest')
  Future<GetLatestCheckInRespModel> getLatestCheckIn();
}
