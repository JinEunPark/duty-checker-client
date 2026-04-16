// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_connection_status_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateConnectionStatusReqModel _$UpdateConnectionStatusReqModelFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateConnectionStatusReqModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateConnectionStatusReqModel {
  String get status => throw _privateConstructorUsedError;

  /// Serializes this UpdateConnectionStatusReqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateConnectionStatusReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateConnectionStatusReqModelCopyWith<UpdateConnectionStatusReqModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateConnectionStatusReqModelCopyWith<$Res> {
  factory $UpdateConnectionStatusReqModelCopyWith(
    UpdateConnectionStatusReqModel value,
    $Res Function(UpdateConnectionStatusReqModel) then,
  ) =
      _$UpdateConnectionStatusReqModelCopyWithImpl<
        $Res,
        UpdateConnectionStatusReqModel
      >;
  @useResult
  $Res call({String status});
}

/// @nodoc
class _$UpdateConnectionStatusReqModelCopyWithImpl<
  $Res,
  $Val extends UpdateConnectionStatusReqModel
>
    implements $UpdateConnectionStatusReqModelCopyWith<$Res> {
  _$UpdateConnectionStatusReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateConnectionStatusReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateConnectionStatusReqModelImplCopyWith<$Res>
    implements $UpdateConnectionStatusReqModelCopyWith<$Res> {
  factory _$$UpdateConnectionStatusReqModelImplCopyWith(
    _$UpdateConnectionStatusReqModelImpl value,
    $Res Function(_$UpdateConnectionStatusReqModelImpl) then,
  ) = __$$UpdateConnectionStatusReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status});
}

/// @nodoc
class __$$UpdateConnectionStatusReqModelImplCopyWithImpl<$Res>
    extends
        _$UpdateConnectionStatusReqModelCopyWithImpl<
          $Res,
          _$UpdateConnectionStatusReqModelImpl
        >
    implements _$$UpdateConnectionStatusReqModelImplCopyWith<$Res> {
  __$$UpdateConnectionStatusReqModelImplCopyWithImpl(
    _$UpdateConnectionStatusReqModelImpl _value,
    $Res Function(_$UpdateConnectionStatusReqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateConnectionStatusReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$UpdateConnectionStatusReqModelImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateConnectionStatusReqModelImpl
    implements _UpdateConnectionStatusReqModel {
  const _$UpdateConnectionStatusReqModelImpl({required this.status});

  factory _$UpdateConnectionStatusReqModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$UpdateConnectionStatusReqModelImplFromJson(json);

  @override
  final String status;

  @override
  String toString() {
    return 'UpdateConnectionStatusReqModel(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateConnectionStatusReqModelImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of UpdateConnectionStatusReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateConnectionStatusReqModelImplCopyWith<
    _$UpdateConnectionStatusReqModelImpl
  >
  get copyWith =>
      __$$UpdateConnectionStatusReqModelImplCopyWithImpl<
        _$UpdateConnectionStatusReqModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateConnectionStatusReqModelImplToJson(this);
  }
}

abstract class _UpdateConnectionStatusReqModel
    implements UpdateConnectionStatusReqModel {
  const factory _UpdateConnectionStatusReqModel({
    required final String status,
  }) = _$UpdateConnectionStatusReqModelImpl;

  factory _UpdateConnectionStatusReqModel.fromJson(Map<String, dynamic> json) =
      _$UpdateConnectionStatusReqModelImpl.fromJson;

  @override
  String get status;

  /// Create a copy of UpdateConnectionStatusReqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateConnectionStatusReqModelImplCopyWith<
    _$UpdateConnectionStatusReqModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
