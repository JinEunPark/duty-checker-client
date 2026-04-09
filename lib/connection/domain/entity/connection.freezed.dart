// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Connection {
  int get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ConnectionStatus get status => throw _privateConstructorUsedError;
  DateTime? get latestCheckedAt => throw _privateConstructorUsedError;
  bool get isTodayChecked => throw _privateConstructorUsedError;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionCopyWith<Connection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionCopyWith<$Res> {
  factory $ConnectionCopyWith(
    Connection value,
    $Res Function(Connection) then,
  ) = _$ConnectionCopyWithImpl<$Res, Connection>;
  @useResult
  $Res call({
    int id,
    String phone,
    String name,
    ConnectionStatus status,
    DateTime? latestCheckedAt,
    bool isTodayChecked,
  });
}

/// @nodoc
class _$ConnectionCopyWithImpl<$Res, $Val extends Connection>
    implements $ConnectionCopyWith<$Res> {
  _$ConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? status = null,
    Object? latestCheckedAt = freezed,
    Object? isTodayChecked = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ConnectionStatus,
            latestCheckedAt: freezed == latestCheckedAt
                ? _value.latestCheckedAt
                : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isTodayChecked: null == isTodayChecked
                ? _value.isTodayChecked
                : isTodayChecked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionImplCopyWith<$Res>
    implements $ConnectionCopyWith<$Res> {
  factory _$$ConnectionImplCopyWith(
    _$ConnectionImpl value,
    $Res Function(_$ConnectionImpl) then,
  ) = __$$ConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String phone,
    String name,
    ConnectionStatus status,
    DateTime? latestCheckedAt,
    bool isTodayChecked,
  });
}

/// @nodoc
class __$$ConnectionImplCopyWithImpl<$Res>
    extends _$ConnectionCopyWithImpl<$Res, _$ConnectionImpl>
    implements _$$ConnectionImplCopyWith<$Res> {
  __$$ConnectionImplCopyWithImpl(
    _$ConnectionImpl _value,
    $Res Function(_$ConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? status = null,
    Object? latestCheckedAt = freezed,
    Object? isTodayChecked = null,
  }) {
    return _then(
      _$ConnectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ConnectionStatus,
        latestCheckedAt: freezed == latestCheckedAt
            ? _value.latestCheckedAt
            : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isTodayChecked: null == isTodayChecked
            ? _value.isTodayChecked
            : isTodayChecked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionImpl extends _Connection {
  const _$ConnectionImpl({
    required this.id,
    required this.phone,
    required this.name,
    required this.status,
    this.latestCheckedAt,
    required this.isTodayChecked,
  }) : super._();

  @override
  final int id;
  @override
  final String phone;
  @override
  final String name;
  @override
  final ConnectionStatus status;
  @override
  final DateTime? latestCheckedAt;
  @override
  final bool isTodayChecked;

  @override
  String toString() {
    return 'Connection(id: $id, phone: $phone, name: $name, status: $status, latestCheckedAt: $latestCheckedAt, isTodayChecked: $isTodayChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latestCheckedAt, latestCheckedAt) ||
                other.latestCheckedAt == latestCheckedAt) &&
            (identical(other.isTodayChecked, isTodayChecked) ||
                other.isTodayChecked == isTodayChecked));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    phone,
    name,
    status,
    latestCheckedAt,
    isTodayChecked,
  );

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionImplCopyWith<_$ConnectionImpl> get copyWith =>
      __$$ConnectionImplCopyWithImpl<_$ConnectionImpl>(this, _$identity);
}

abstract class _Connection extends Connection {
  const factory _Connection({
    required final int id,
    required final String phone,
    required final String name,
    required final ConnectionStatus status,
    final DateTime? latestCheckedAt,
    required final bool isTodayChecked,
  }) = _$ConnectionImpl;
  const _Connection._() : super._();

  @override
  int get id;
  @override
  String get phone;
  @override
  String get name;
  @override
  ConnectionStatus get status;
  @override
  DateTime? get latestCheckedAt;
  @override
  bool get isTodayChecked;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionImplCopyWith<_$ConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConnectionList {
  UserRole get role => throw _privateConstructorUsedError;
  List<Connection> get connections => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionListCopyWith<ConnectionList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionListCopyWith<$Res> {
  factory $ConnectionListCopyWith(
    ConnectionList value,
    $Res Function(ConnectionList) then,
  ) = _$ConnectionListCopyWithImpl<$Res, ConnectionList>;
  @useResult
  $Res call({UserRole role, List<Connection> connections});
}

/// @nodoc
class _$ConnectionListCopyWithImpl<$Res, $Val extends ConnectionList>
    implements $ConnectionListCopyWith<$Res> {
  _$ConnectionListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null, Object? connections = null}) {
    return _then(
      _value.copyWith(
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            connections: null == connections
                ? _value.connections
                : connections // ignore: cast_nullable_to_non_nullable
                      as List<Connection>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionListImplCopyWith<$Res>
    implements $ConnectionListCopyWith<$Res> {
  factory _$$ConnectionListImplCopyWith(
    _$ConnectionListImpl value,
    $Res Function(_$ConnectionListImpl) then,
  ) = __$$ConnectionListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserRole role, List<Connection> connections});
}

/// @nodoc
class __$$ConnectionListImplCopyWithImpl<$Res>
    extends _$ConnectionListCopyWithImpl<$Res, _$ConnectionListImpl>
    implements _$$ConnectionListImplCopyWith<$Res> {
  __$$ConnectionListImplCopyWithImpl(
    _$ConnectionListImpl _value,
    $Res Function(_$ConnectionListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null, Object? connections = null}) {
    return _then(
      _$ConnectionListImpl(
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        connections: null == connections
            ? _value._connections
            : connections // ignore: cast_nullable_to_non_nullable
                  as List<Connection>,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionListImpl implements _ConnectionList {
  const _$ConnectionListImpl({
    required this.role,
    required final List<Connection> connections,
  }) : _connections = connections;

  @override
  final UserRole role;
  final List<Connection> _connections;
  @override
  List<Connection> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  @override
  String toString() {
    return 'ConnectionList(role: $role, connections: $connections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionListImpl &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other._connections,
              _connections,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    role,
    const DeepCollectionEquality().hash(_connections),
  );

  /// Create a copy of ConnectionList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionListImplCopyWith<_$ConnectionListImpl> get copyWith =>
      __$$ConnectionListImplCopyWithImpl<_$ConnectionListImpl>(
        this,
        _$identity,
      );
}

abstract class _ConnectionList implements ConnectionList {
  const factory _ConnectionList({
    required final UserRole role,
    required final List<Connection> connections,
  }) = _$ConnectionListImpl;

  @override
  UserRole get role;
  @override
  List<Connection> get connections;

  /// Create a copy of ConnectionList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionListImplCopyWith<_$ConnectionListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
