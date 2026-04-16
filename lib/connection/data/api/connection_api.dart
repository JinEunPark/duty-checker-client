import 'package:dio/dio.dart';
import 'package:duty_checker/connection/data/model/connection_req_model.dart';
import 'package:duty_checker/connection/data/model/connection_resp_model.dart';
import 'package:duty_checker/connection/data/model/update_connection_name_req_model.dart';
import 'package:duty_checker/connection/data/model/update_connection_status_req_model.dart';
import 'package:retrofit/retrofit.dart';

import '../model/get_connections_resp_model.dart';

part 'connection_api.g.dart';

@RestApi()
abstract class ConnectionApi {
  factory ConnectionApi(Dio dio, {String baseUrl}) = _ConnectionApi;

  @GET('/v1/connections')
  Future<GetConnectionsRespModel> getConnections();

  @POST('/v1/connections')
  Future<ConnectionRespModel> addConnection(@Body() ConnectionReqModel body);

  @PATCH('/v1/connections/{id}/name')
  Future<ConnectionRespModel> updateConnectionName(
    @Path('id') int id,
    @Body() UpdateConnectionNameReqModel body,
  );

  @PATCH('/v1/connections/{id}/status')
  Future<void> updateConnectionStatus(
    @Path('id') int id,
    @Body() UpdateConnectionStatusReqModel body,
  );

  @DELETE('/v1/connections/{id}')
  Future<void> deleteConnection(@Path('id') int id);
}