import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_code_resp_model.freezed.dart';
part 'send_code_resp_model.g.dart';

@freezed
class SendCodeRespModel with _$SendCodeRespModel {
  const factory SendCodeRespModel({
    String? expiredAt,
  }) = _SendCodeRespModel;

  factory SendCodeRespModel.fromJson(Map<String, dynamic> json) =>
      _$SendCodeRespModelFromJson(json);
}
