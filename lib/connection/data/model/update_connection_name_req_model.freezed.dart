// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_connection_name_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateConnectionNameReqModel _$UpdateConnectionNameReqModelFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateConnectionNameReqModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateConnectionNameReqModel {
  String get name => throw _privateConstructorUsedError;

  /// Serializes this UpdateConnectionNameReqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateConnectionNameReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateConnectionNameReqModelCopyWith<UpdateConnectionNameReqModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateConnectionNameReqModelCopyWith<$Res> {
  factory $UpdateConnectionNameReqModelCopyWith(
    UpdateConnectionNameReqModel value,
    $Res Function(UpdateConnectionNameReqModel) then,
  ) =
      _$UpdateConnectionNameReqModelCopyWithImpl<
        $Res,
        UpdateConnectionNameReqModel
      >;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$UpdateConnectionNameReqModelCopyWithImpl<
  $Res,
  $Val extends UpdateConnectionNameReqModel
>
    implements $UpdateConnectionNameReqModelCopyWith<$Res> {
  _$UpdateConnectionNameReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateConnectionNameReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateConnectionNameReqModelImplCopyWith<$Res>
    implements $UpdateConnectionNameReqModelCopyWith<$Res> {
  factory _$$UpdateConnectionNameReqModelImplCopyWith(
    _$UpdateConnectionNameReqModelImpl value,
    $Res Function(_$UpdateConnectionNameReqModelImpl) then,
  ) = __$$UpdateConnectionNameReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$UpdateConnectionNameReqModelImplCopyWithImpl<$Res>
    extends
        _$UpdateConnectionNameReqModelCopyWithImpl<
          $Res,
          _$UpdateConnectionNameReqModelImpl
        >
    implements _$$UpdateConnectionNameReqModelImplCopyWith<$Res> {
  __$$UpdateConnectionNameReqModelImplCopyWithImpl(
    _$UpdateConnectionNameReqModelImpl _value,
    $Res Function(_$UpdateConnectionNameReqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateConnectionNameReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$UpdateConnectionNameReqModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateConnectionNameReqModelImpl
    implements _UpdateConnectionNameReqModel {
  const _$UpdateConnectionNameReqModelImpl({required this.name});

  factory _$UpdateConnectionNameReqModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$UpdateConnectionNameReqModelImplFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'UpdateConnectionNameReqModel(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateConnectionNameReqModelImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of UpdateConnectionNameReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateConnectionNameReqModelImplCopyWith<
    _$UpdateConnectionNameReqModelImpl
  >
  get copyWith =>
      __$$UpdateConnectionNameReqModelImplCopyWithImpl<
        _$UpdateConnectionNameReqModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateConnectionNameReqModelImplToJson(this);
  }
}

abstract class _UpdateConnectionNameReqModel
    implements UpdateConnectionNameReqModel {
  const factory _UpdateConnectionNameReqModel({required final String name}) =
      _$UpdateConnectionNameReqModelImpl;

  factory _UpdateConnectionNameReqModel.fromJson(Map<String, dynamic> json) =
      _$UpdateConnectionNameReqModelImpl.fromJson;

  @override
  String get name;

  /// Create a copy of UpdateConnectionNameReqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateConnectionNameReqModelImplCopyWith<
    _$UpdateConnectionNameReqModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
