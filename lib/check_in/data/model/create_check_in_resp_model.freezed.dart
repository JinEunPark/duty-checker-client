// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_check_in_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateCheckInRespModel _$CreateCheckInRespModelFromJson(
  Map<String, dynamic> json,
) {
  return _CreateCheckInRespModel.fromJson(json);
}

/// @nodoc
mixin _$CreateCheckInRespModel {
  int? get id => throw _privateConstructorUsedError;
  String? get checkedAt => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this CreateCheckInRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCheckInRespModelCopyWith<CreateCheckInRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCheckInRespModelCopyWith<$Res> {
  factory $CreateCheckInRespModelCopyWith(
    CreateCheckInRespModel value,
    $Res Function(CreateCheckInRespModel) then,
  ) = _$CreateCheckInRespModelCopyWithImpl<$Res, CreateCheckInRespModel>;
  @useResult
  $Res call({int? id, String? checkedAt, String? status});
}

/// @nodoc
class _$CreateCheckInRespModelCopyWithImpl<
  $Res,
  $Val extends CreateCheckInRespModel
>
    implements $CreateCheckInRespModelCopyWith<$Res> {
  _$CreateCheckInRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? checkedAt = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            checkedAt: freezed == checkedAt
                ? _value.checkedAt
                : checkedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateCheckInRespModelImplCopyWith<$Res>
    implements $CreateCheckInRespModelCopyWith<$Res> {
  factory _$$CreateCheckInRespModelImplCopyWith(
    _$CreateCheckInRespModelImpl value,
    $Res Function(_$CreateCheckInRespModelImpl) then,
  ) = __$$CreateCheckInRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? checkedAt, String? status});
}

/// @nodoc
class __$$CreateCheckInRespModelImplCopyWithImpl<$Res>
    extends
        _$CreateCheckInRespModelCopyWithImpl<$Res, _$CreateCheckInRespModelImpl>
    implements _$$CreateCheckInRespModelImplCopyWith<$Res> {
  __$$CreateCheckInRespModelImplCopyWithImpl(
    _$CreateCheckInRespModelImpl _value,
    $Res Function(_$CreateCheckInRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? checkedAt = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$CreateCheckInRespModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        checkedAt: freezed == checkedAt
            ? _value.checkedAt
            : checkedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCheckInRespModelImpl implements _CreateCheckInRespModel {
  const _$CreateCheckInRespModelImpl({this.id, this.checkedAt, this.status});

  factory _$CreateCheckInRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCheckInRespModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? checkedAt;
  @override
  final String? status;

  @override
  String toString() {
    return 'CreateCheckInRespModel(id: $id, checkedAt: $checkedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCheckInRespModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.checkedAt, checkedAt) ||
                other.checkedAt == checkedAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, checkedAt, status);

  /// Create a copy of CreateCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCheckInRespModelImplCopyWith<_$CreateCheckInRespModelImpl>
  get copyWith =>
      __$$CreateCheckInRespModelImplCopyWithImpl<_$CreateCheckInRespModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCheckInRespModelImplToJson(this);
  }
}

abstract class _CreateCheckInRespModel implements CreateCheckInRespModel {
  const factory _CreateCheckInRespModel({
    final int? id,
    final String? checkedAt,
    final String? status,
  }) = _$CreateCheckInRespModelImpl;

  factory _CreateCheckInRespModel.fromJson(Map<String, dynamic> json) =
      _$CreateCheckInRespModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get checkedAt;
  @override
  String? get status;

  /// Create a copy of CreateCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCheckInRespModelImplCopyWith<_$CreateCheckInRespModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
