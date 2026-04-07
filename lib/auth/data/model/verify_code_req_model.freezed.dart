// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_code_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyCodeReqModel _$VerifyCodeReqModelFromJson(Map<String, dynamic> json) {
  return _VerifyCodeReqModel.fromJson(json);
}

/// @nodoc
mixin _$VerifyCodeReqModel {
  String get phone => throw _privateConstructorUsedError;
  String get verificationCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyCodeReqModelCopyWith<VerifyCodeReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyCodeReqModelCopyWith<$Res> {
  factory $VerifyCodeReqModelCopyWith(
          VerifyCodeReqModel value, $Res Function(VerifyCodeReqModel) then) =
      _$VerifyCodeReqModelCopyWithImpl<$Res, VerifyCodeReqModel>;
  @useResult
  $Res call({String phone, String verificationCode});
}

/// @nodoc
class _$VerifyCodeReqModelCopyWithImpl<$Res, $Val extends VerifyCodeReqModel>
    implements $VerifyCodeReqModelCopyWith<$Res> {
  _$VerifyCodeReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? verificationCode = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyCodeReqModelImplCopyWith<$Res>
    implements $VerifyCodeReqModelCopyWith<$Res> {
  factory _$$VerifyCodeReqModelImplCopyWith(_$VerifyCodeReqModelImpl value,
          $Res Function(_$VerifyCodeReqModelImpl) then) =
      __$$VerifyCodeReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String verificationCode});
}

/// @nodoc
class __$$VerifyCodeReqModelImplCopyWithImpl<$Res>
    extends _$VerifyCodeReqModelCopyWithImpl<$Res, _$VerifyCodeReqModelImpl>
    implements _$$VerifyCodeReqModelImplCopyWith<$Res> {
  __$$VerifyCodeReqModelImplCopyWithImpl(_$VerifyCodeReqModelImpl _value,
      $Res Function(_$VerifyCodeReqModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? verificationCode = null,
  }) {
    return _then(_$VerifyCodeReqModelImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyCodeReqModelImpl implements _VerifyCodeReqModel {
  const _$VerifyCodeReqModelImpl(
      {required this.phone, required this.verificationCode});

  factory _$VerifyCodeReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyCodeReqModelImplFromJson(json);

  @override
  final String phone;
  @override
  final String verificationCode;

  @override
  String toString() {
    return 'VerifyCodeReqModel(phone: $phone, verificationCode: $verificationCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyCodeReqModelImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.verificationCode, verificationCode) ||
                other.verificationCode == verificationCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone, verificationCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyCodeReqModelImplCopyWith<_$VerifyCodeReqModelImpl> get copyWith =>
      __$$VerifyCodeReqModelImplCopyWithImpl<_$VerifyCodeReqModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyCodeReqModelImplToJson(
      this,
    );
  }
}

abstract class _VerifyCodeReqModel implements VerifyCodeReqModel {
  const factory _VerifyCodeReqModel(
      {required final String phone,
      required final String verificationCode}) = _$VerifyCodeReqModelImpl;

  factory _VerifyCodeReqModel.fromJson(Map<String, dynamic> json) =
      _$VerifyCodeReqModelImpl.fromJson;

  @override
  String get phone;
  @override
  String get verificationCode;
  @override
  @JsonKey(ignore: true)
  _$$VerifyCodeReqModelImplCopyWith<_$VerifyCodeReqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
