// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConnectionReqModel _$ConnectionReqModelFromJson(Map<String, dynamic> json) {
  return _ConnectionReqModel.fromJson(json);
}

/// @nodoc
mixin _$ConnectionReqModel {
  String get targetPhone => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this ConnectionReqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionReqModelCopyWith<ConnectionReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionReqModelCopyWith<$Res> {
  factory $ConnectionReqModelCopyWith(
    ConnectionReqModel value,
    $Res Function(ConnectionReqModel) then,
  ) = _$ConnectionReqModelCopyWithImpl<$Res, ConnectionReqModel>;
  @useResult
  $Res call({String targetPhone, String? name});
}

/// @nodoc
class _$ConnectionReqModelCopyWithImpl<$Res, $Val extends ConnectionReqModel>
    implements $ConnectionReqModelCopyWith<$Res> {
  _$ConnectionReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? targetPhone = null, Object? name = freezed}) {
    return _then(
      _value.copyWith(
            targetPhone: null == targetPhone
                ? _value.targetPhone
                : targetPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionReqModelImplCopyWith<$Res>
    implements $ConnectionReqModelCopyWith<$Res> {
  factory _$$ConnectionReqModelImplCopyWith(
    _$ConnectionReqModelImpl value,
    $Res Function(_$ConnectionReqModelImpl) then,
  ) = __$$ConnectionReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String targetPhone, String? name});
}

/// @nodoc
class __$$ConnectionReqModelImplCopyWithImpl<$Res>
    extends _$ConnectionReqModelCopyWithImpl<$Res, _$ConnectionReqModelImpl>
    implements _$$ConnectionReqModelImplCopyWith<$Res> {
  __$$ConnectionReqModelImplCopyWithImpl(
    _$ConnectionReqModelImpl _value,
    $Res Function(_$ConnectionReqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? targetPhone = null, Object? name = freezed}) {
    return _then(
      _$ConnectionReqModelImpl(
        targetPhone: null == targetPhone
            ? _value.targetPhone
            : targetPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionReqModelImpl implements _ConnectionReqModel {
  const _$ConnectionReqModelImpl({required this.targetPhone, this.name});

  factory _$ConnectionReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionReqModelImplFromJson(json);

  @override
  final String targetPhone;
  @override
  final String? name;

  @override
  String toString() {
    return 'ConnectionReqModel(targetPhone: $targetPhone, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionReqModelImpl &&
            (identical(other.targetPhone, targetPhone) ||
                other.targetPhone == targetPhone) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, targetPhone, name);

  /// Create a copy of ConnectionReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionReqModelImplCopyWith<_$ConnectionReqModelImpl> get copyWith =>
      __$$ConnectionReqModelImplCopyWithImpl<_$ConnectionReqModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionReqModelImplToJson(this);
  }
}

abstract class _ConnectionReqModel implements ConnectionReqModel {
  const factory _ConnectionReqModel({
    required final String targetPhone,
    final String? name,
  }) = _$ConnectionReqModelImpl;

  factory _ConnectionReqModel.fromJson(Map<String, dynamic> json) =
      _$ConnectionReqModelImpl.fromJson;

  @override
  String get targetPhone;
  @override
  String? get name;

  /// Create a copy of ConnectionReqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionReqModelImplCopyWith<_$ConnectionReqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
