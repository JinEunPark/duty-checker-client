import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_req_model.freezed.dart';
part 'register_req_model.g.dart';

@freezed
class RegisterReqModel with _$RegisterReqModel {
  const factory RegisterReqModel({
    required String phone,
    required String password,
    required String role,
  }) = _RegisterReqModel;

  factory RegisterReqModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterReqModelFromJson(json);
}
