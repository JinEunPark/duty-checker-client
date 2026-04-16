// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_phone_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CheckPhoneRespModel _$CheckPhoneRespModelFromJson(Map<String, dynamic> json) {
  return _CheckPhoneRespModel.fromJson(json);
}

/// @nodoc
mixin _$CheckPhoneRespModel {
  bool get exists => throw _privateConstructorUsedError;

  /// Serializes this CheckPhoneRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckPhoneRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckPhoneRespModelCopyWith<CheckPhoneRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckPhoneRespModelCopyWith<$Res> {
  factory $CheckPhoneRespModelCopyWith(
    CheckPhoneRespModel value,
    $Res Function(CheckPhoneRespModel) then,
  ) = _$CheckPhoneRespModelCopyWithImpl<$Res, CheckPhoneRespModel>;
  @useResult
  $Res call({bool exists});
}

/// @nodoc
class _$CheckPhoneRespModelCopyWithImpl<$Res, $Val extends CheckPhoneRespModel>
    implements $CheckPhoneRespModelCopyWith<$Res> {
  _$CheckPhoneRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckPhoneRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? exists = null}) {
    return _then(
      _value.copyWith(
            exists: null == exists
                ? _value.exists
                : exists // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckPhoneRespModelImplCopyWith<$Res>
    implements $CheckPhoneRespModelCopyWith<$Res> {
  factory _$$CheckPhoneRespModelImplCopyWith(
    _$CheckPhoneRespModelImpl value,
    $Res Function(_$CheckPhoneRespModelImpl) then,
  ) = __$$CheckPhoneRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool exists});
}

/// @nodoc
class __$$CheckPhoneRespModelImplCopyWithImpl<$Res>
    extends _$CheckPhoneRespModelCopyWithImpl<$Res, _$CheckPhoneRespModelImpl>
    implements _$$CheckPhoneRespModelImplCopyWith<$Res> {
  __$$CheckPhoneRespModelImplCopyWithImpl(
    _$CheckPhoneRespModelImpl _value,
    $Res Function(_$CheckPhoneRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckPhoneRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? exists = null}) {
    return _then(
      _$CheckPhoneRespModelImpl(
        exists: null == exists
            ? _value.exists
            : exists // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckPhoneRespModelImpl implements _CheckPhoneRespModel {
  const _$CheckPhoneRespModelImpl({this.exists = false});

  factory _$CheckPhoneRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckPhoneRespModelImplFromJson(json);

  @override
  @JsonKey()
  final bool exists;

  @override
  String toString() {
    return 'CheckPhoneRespModel(exists: $exists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckPhoneRespModelImpl &&
            (identical(other.exists, exists) || other.exists == exists));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, exists);

  /// Create a copy of CheckPhoneRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckPhoneRespModelImplCopyWith<_$CheckPhoneRespModelImpl> get copyWith =>
      __$$CheckPhoneRespModelImplCopyWithImpl<_$CheckPhoneRespModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckPhoneRespModelImplToJson(this);
  }
}

abstract class _CheckPhoneRespModel implements CheckPhoneRespModel {
  const factory _CheckPhoneRespModel({final bool exists}) =
      _$CheckPhoneRespModelImpl;

  factory _CheckPhoneRespModel.fromJson(Map<String, dynamic> json) =
      _$CheckPhoneRespModelImpl.fromJson;

  @override
  bool get exists;

  /// Create a copy of CheckPhoneRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckPhoneRespModelImplCopyWith<_$CheckPhoneRespModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
