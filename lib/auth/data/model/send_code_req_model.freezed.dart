// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_code_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendCodeReqModel _$SendCodeReqModelFromJson(Map<String, dynamic> json) {
  return _SendCodeReqModel.fromJson(json);
}

/// @nodoc
mixin _$SendCodeReqModel {
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendCodeReqModelCopyWith<SendCodeReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendCodeReqModelCopyWith<$Res> {
  factory $SendCodeReqModelCopyWith(
          SendCodeReqModel value, $Res Function(SendCodeReqModel) then) =
      _$SendCodeReqModelCopyWithImpl<$Res, SendCodeReqModel>;
  @useResult
  $Res call({String phone});
}

/// @nodoc
class _$SendCodeReqModelCopyWithImpl<$Res, $Val extends SendCodeReqModel>
    implements $SendCodeReqModelCopyWith<$Res> {
  _$SendCodeReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendCodeReqModelImplCopyWith<$Res>
    implements $SendCodeReqModelCopyWith<$Res> {
  factory _$$SendCodeReqModelImplCopyWith(_$SendCodeReqModelImpl value,
          $Res Function(_$SendCodeReqModelImpl) then) =
      __$$SendCodeReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone});
}

/// @nodoc
class __$$SendCodeReqModelImplCopyWithImpl<$Res>
    extends _$SendCodeReqModelCopyWithImpl<$Res, _$SendCodeReqModelImpl>
    implements _$$SendCodeReqModelImplCopyWith<$Res> {
  __$$SendCodeReqModelImplCopyWithImpl(_$SendCodeReqModelImpl _value,
      $Res Function(_$SendCodeReqModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$SendCodeReqModelImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendCodeReqModelImpl implements _SendCodeReqModel {
  const _$SendCodeReqModelImpl({required this.phone});

  factory _$SendCodeReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendCodeReqModelImplFromJson(json);

  @override
  final String phone;

  @override
  String toString() {
    return 'SendCodeReqModel(phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendCodeReqModelImpl &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendCodeReqModelImplCopyWith<_$SendCodeReqModelImpl> get copyWith =>
      __$$SendCodeReqModelImplCopyWithImpl<_$SendCodeReqModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendCodeReqModelImplToJson(
      this,
    );
  }
}

abstract class _SendCodeReqModel implements SendCodeReqModel {
  const factory _SendCodeReqModel({required final String phone}) =
      _$SendCodeReqModelImpl;

  factory _SendCodeReqModel.fromJson(Map<String, dynamic> json) =
      _$SendCodeReqModelImpl.fromJson;

  @override
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$SendCodeReqModelImplCopyWith<_$SendCodeReqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
