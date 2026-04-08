// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyCodeReqModelImpl _$$VerifyCodeReqModelImplFromJson(
  Map<String, dynamic> json,
) => _$VerifyCodeReqModelImpl(
  phone: json['phone'] as String,
  verificationCode: json['verificationCode'] as String,
);

Map<String, dynamic> _$$VerifyCodeReqModelImplToJson(
  _$VerifyCodeReqModelImpl instance,
) => <String, dynamic>{
  'phone': instance.phone,
  'verificationCode': instance.verificationCode,
};
