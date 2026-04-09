// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_connections_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GetConnectionsRespModel _$GetConnectionsRespModelFromJson(
  Map<String, dynamic> json,
) {
  return _GetConnectionsRespModel.fromJson(json);
}

/// @nodoc
mixin _$GetConnectionsRespModel {
  String? get role => throw _privateConstructorUsedError;
  List<ConnectionRespModel>? get connections =>
      throw _privateConstructorUsedError;

  /// Serializes this GetConnectionsRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetConnectionsRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetConnectionsRespModelCopyWith<GetConnectionsRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetConnectionsRespModelCopyWith<$Res> {
  factory $GetConnectionsRespModelCopyWith(
    GetConnectionsRespModel value,
    $Res Function(GetConnectionsRespModel) then,
  ) = _$GetConnectionsRespModelCopyWithImpl<$Res, GetConnectionsRespModel>;
  @useResult
  $Res call({String? role, List<ConnectionRespModel>? connections});
}

/// @nodoc
class _$GetConnectionsRespModelCopyWithImpl<
  $Res,
  $Val extends GetConnectionsRespModel
>
    implements $GetConnectionsRespModelCopyWith<$Res> {
  _$GetConnectionsRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetConnectionsRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = freezed, Object? connections = freezed}) {
    return _then(
      _value.copyWith(
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            connections: freezed == connections
                ? _value.connections
                : connections // ignore: cast_nullable_to_non_nullable
                      as List<ConnectionRespModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetConnectionsRespModelImplCopyWith<$Res>
    implements $GetConnectionsRespModelCopyWith<$Res> {
  factory _$$GetConnectionsRespModelImplCopyWith(
    _$GetConnectionsRespModelImpl value,
    $Res Function(_$GetConnectionsRespModelImpl) then,
  ) = __$$GetConnectionsRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? role, List<ConnectionRespModel>? connections});
}

/// @nodoc
class __$$GetConnectionsRespModelImplCopyWithImpl<$Res>
    extends
        _$GetConnectionsRespModelCopyWithImpl<
          $Res,
          _$GetConnectionsRespModelImpl
        >
    implements _$$GetConnectionsRespModelImplCopyWith<$Res> {
  __$$GetConnectionsRespModelImplCopyWithImpl(
    _$GetConnectionsRespModelImpl _value,
    $Res Function(_$GetConnectionsRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GetConnectionsRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = freezed, Object? connections = freezed}) {
    return _then(
      _$GetConnectionsRespModelImpl(
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        connections: freezed == connections
            ? _value._connections
            : connections // ignore: cast_nullable_to_non_nullable
                  as List<ConnectionRespModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GetConnectionsRespModelImpl implements _GetConnectionsRespModel {
  const _$GetConnectionsRespModelImpl({
    this.role,
    final List<ConnectionRespModel>? connections,
  }) : _connections = connections;

  factory _$GetConnectionsRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetConnectionsRespModelImplFromJson(json);

  @override
  final String? role;
  final List<ConnectionRespModel>? _connections;
  @override
  List<ConnectionRespModel>? get connections {
    final value = _connections;
    if (value == null) return null;
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetConnectionsRespModel(role: $role, connections: $connections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetConnectionsRespModelImpl &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._connections,
              _connections,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    role,
    const DeepCollectionEquality().hash(_connections),
  );

  /// Create a copy of GetConnectionsRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetConnectionsRespModelImplCopyWith<_$GetConnectionsRespModelImpl>
  get copyWith =>
      __$$GetConnectionsRespModelImplCopyWithImpl<
        _$GetConnectionsRespModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetConnectionsRespModelImplToJson(this);
  }
}

abstract class _GetConnectionsRespModel implements GetConnectionsRespModel {
  const factory _GetConnectionsRespModel({
    final String? role,
    final List<ConnectionRespModel>? connections,
  }) = _$GetConnectionsRespModelImpl;

  factory _GetConnectionsRespModel.fromJson(Map<String, dynamic> json) =
      _$GetConnectionsRespModelImpl.fromJson;

  @override
  String? get role;
  @override
  List<ConnectionRespModel>? get connections;

  /// Create a copy of GetConnectionsRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetConnectionsRespModelImplCopyWith<_$GetConnectionsRespModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
