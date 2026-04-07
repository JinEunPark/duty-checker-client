// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_code_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendCodeRespModel _$SendCodeRespModelFromJson(Map<String, dynamic> json) {
  return _SendCodeRespModel.fromJson(json);
}

/// @nodoc
mixin _$SendCodeRespModel {
  String? get expiredAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendCodeRespModelCopyWith<SendCodeRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendCodeRespModelCopyWith<$Res> {
  factory $SendCodeRespModelCopyWith(
          SendCodeRespModel value, $Res Function(SendCodeRespModel) then) =
      _$SendCodeRespModelCopyWithImpl<$Res, SendCodeRespModel>;
  @useResult
  $Res call({String? expiredAt});
}

/// @nodoc
class _$SendCodeRespModelCopyWithImpl<$Res, $Val extends SendCodeRespModel>
    implements $SendCodeRespModelCopyWith<$Res> {
  _$SendCodeRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiredAt = freezed,
  }) {
    return _then(_value.copyWith(
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendCodeRespModelImplCopyWith<$Res>
    implements $SendCodeRespModelCopyWith<$Res> {
  factory _$$SendCodeRespModelImplCopyWith(_$SendCodeRespModelImpl value,
          $Res Function(_$SendCodeRespModelImpl) then) =
      __$$SendCodeRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? expiredAt});
}

/// @nodoc
class __$$SendCodeRespModelImplCopyWithImpl<$Res>
    extends _$SendCodeRespModelCopyWithImpl<$Res, _$SendCodeRespModelImpl>
    implements _$$SendCodeRespModelImplCopyWith<$Res> {
  __$$SendCodeRespModelImplCopyWithImpl(_$SendCodeRespModelImpl _value,
      $Res Function(_$SendCodeRespModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiredAt = freezed,
  }) {
    return _then(_$SendCodeRespModelImpl(
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendCodeRespModelImpl implements _SendCodeRespModel {
  const _$SendCodeRespModelImpl({this.expiredAt});

  factory _$SendCodeRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendCodeRespModelImplFromJson(json);

  @override
  final String? expiredAt;

  @override
  String toString() {
    return 'SendCodeRespModel(expiredAt: $expiredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendCodeRespModelImpl &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, expiredAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendCodeRespModelImplCopyWith<_$SendCodeRespModelImpl> get copyWith =>
      __$$SendCodeRespModelImplCopyWithImpl<_$SendCodeRespModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendCodeRespModelImplToJson(
      this,
    );
  }
}

abstract class _SendCodeRespModel implements SendCodeRespModel {
  const factory _SendCodeRespModel({final String? expiredAt}) =
      _$SendCodeRespModelImpl;

  factory _SendCodeRespModel.fromJson(Map<String, dynamic> json) =
      _$SendCodeRespModelImpl.fromJson;

  @override
  String? get expiredAt;
  @override
  @JsonKey(ignore: true)
  _$$SendCodeRespModelImplCopyWith<_$SendCodeRespModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
