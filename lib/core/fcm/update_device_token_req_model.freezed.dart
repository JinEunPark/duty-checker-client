// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_device_token_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateDeviceTokenReqModel _$UpdateDeviceTokenReqModelFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateDeviceTokenReqModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateDeviceTokenReqModel {
  String get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this UpdateDeviceTokenReqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateDeviceTokenReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateDeviceTokenReqModelCopyWith<UpdateDeviceTokenReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateDeviceTokenReqModelCopyWith<$Res> {
  factory $UpdateDeviceTokenReqModelCopyWith(
    UpdateDeviceTokenReqModel value,
    $Res Function(UpdateDeviceTokenReqModel) then,
  ) = _$UpdateDeviceTokenReqModelCopyWithImpl<$Res, UpdateDeviceTokenReqModel>;
  @useResult
  $Res call({String fcmToken});
}

/// @nodoc
class _$UpdateDeviceTokenReqModelCopyWithImpl<
  $Res,
  $Val extends UpdateDeviceTokenReqModel
>
    implements $UpdateDeviceTokenReqModelCopyWith<$Res> {
  _$UpdateDeviceTokenReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateDeviceTokenReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fcmToken = null}) {
    return _then(
      _value.copyWith(
            fcmToken: null == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateDeviceTokenReqModelImplCopyWith<$Res>
    implements $UpdateDeviceTokenReqModelCopyWith<$Res> {
  factory _$$UpdateDeviceTokenReqModelImplCopyWith(
    _$UpdateDeviceTokenReqModelImpl value,
    $Res Function(_$UpdateDeviceTokenReqModelImpl) then,
  ) = __$$UpdateDeviceTokenReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fcmToken});
}

/// @nodoc
class __$$UpdateDeviceTokenReqModelImplCopyWithImpl<$Res>
    extends
        _$UpdateDeviceTokenReqModelCopyWithImpl<
          $Res,
          _$UpdateDeviceTokenReqModelImpl
        >
    implements _$$UpdateDeviceTokenReqModelImplCopyWith<$Res> {
  __$$UpdateDeviceTokenReqModelImplCopyWithImpl(
    _$UpdateDeviceTokenReqModelImpl _value,
    $Res Function(_$UpdateDeviceTokenReqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateDeviceTokenReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fcmToken = null}) {
    return _then(
      _$UpdateDeviceTokenReqModelImpl(
        fcmToken: null == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateDeviceTokenReqModelImpl implements _UpdateDeviceTokenReqModel {
  const _$UpdateDeviceTokenReqModelImpl({required this.fcmToken});

  factory _$UpdateDeviceTokenReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateDeviceTokenReqModelImplFromJson(json);

  @override
  final String fcmToken;

  @override
  String toString() {
    return 'UpdateDeviceTokenReqModel(fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDeviceTokenReqModelImpl &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fcmToken);

  /// Create a copy of UpdateDeviceTokenReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDeviceTokenReqModelImplCopyWith<_$UpdateDeviceTokenReqModelImpl>
  get copyWith =>
      __$$UpdateDeviceTokenReqModelImplCopyWithImpl<
        _$UpdateDeviceTokenReqModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateDeviceTokenReqModelImplToJson(this);
  }
}

abstract class _UpdateDeviceTokenReqModel implements UpdateDeviceTokenReqModel {
  const factory _UpdateDeviceTokenReqModel({required final String fcmToken}) =
      _$UpdateDeviceTokenReqModelImpl;

  factory _UpdateDeviceTokenReqModel.fromJson(Map<String, dynamic> json) =
      _$UpdateDeviceTokenReqModelImpl.fromJson;

  @override
  String get fcmToken;

  /// Create a copy of UpdateDeviceTokenReqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDeviceTokenReqModelImplCopyWith<_$UpdateDeviceTokenReqModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
