// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckIn {
  int get id => throw _privateConstructorUsedError;
  DateTime get checkedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of CheckIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInCopyWith<CheckIn> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInCopyWith<$Res> {
  factory $CheckInCopyWith(CheckIn value, $Res Function(CheckIn) then) =
      _$CheckInCopyWithImpl<$Res, CheckIn>;
  @useResult
  $Res call({int id, DateTime checkedAt, String status});
}

/// @nodoc
class _$CheckInCopyWithImpl<$Res, $Val extends CheckIn>
    implements $CheckInCopyWith<$Res> {
  _$CheckInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? checkedAt = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            checkedAt: null == checkedAt
                ? _value.checkedAt
                : checkedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$CheckInImplCopyWith<$Res> implements $CheckInCopyWith<$Res> {
  factory _$$CheckInImplCopyWith(
    _$CheckInImpl value,
    $Res Function(_$CheckInImpl) then,
  ) = __$$CheckInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, DateTime checkedAt, String status});
}

/// @nodoc
class __$$CheckInImplCopyWithImpl<$Res>
    extends _$CheckInCopyWithImpl<$Res, _$CheckInImpl>
    implements _$$CheckInImplCopyWith<$Res> {
  __$$CheckInImplCopyWithImpl(
    _$CheckInImpl _value,
    $Res Function(_$CheckInImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? checkedAt = null,
    Object? status = null,
  }) {
    return _then(
      _$CheckInImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        checkedAt: null == checkedAt
            ? _value.checkedAt
            : checkedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CheckInImpl implements _CheckIn {
  const _$CheckInImpl({
    required this.id,
    required this.checkedAt,
    required this.status,
  });

  @override
  final int id;
  @override
  final DateTime checkedAt;
  @override
  final String status;

  @override
  String toString() {
    return 'CheckIn(id: $id, checkedAt: $checkedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.checkedAt, checkedAt) ||
                other.checkedAt == checkedAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, checkedAt, status);

  /// Create a copy of CheckIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInImplCopyWith<_$CheckInImpl> get copyWith =>
      __$$CheckInImplCopyWithImpl<_$CheckInImpl>(this, _$identity);
}

abstract class _CheckIn implements CheckIn {
  const factory _CheckIn({
    required final int id,
    required final DateTime checkedAt,
    required final String status,
  }) = _$CheckInImpl;

  @override
  int get id;
  @override
  DateTime get checkedAt;
  @override
  String get status;

  /// Create a copy of CheckIn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInImplCopyWith<_$CheckInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LatestCheckIn {
  DateTime? get latestCheckedAt => throw _privateConstructorUsedError;
  bool get todayChecked => throw _privateConstructorUsedError;

  /// Create a copy of LatestCheckIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatestCheckInCopyWith<LatestCheckIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestCheckInCopyWith<$Res> {
  factory $LatestCheckInCopyWith(
    LatestCheckIn value,
    $Res Function(LatestCheckIn) then,
  ) = _$LatestCheckInCopyWithImpl<$Res, LatestCheckIn>;
  @useResult
  $Res call({DateTime? latestCheckedAt, bool todayChecked});
}

/// @nodoc
class _$LatestCheckInCopyWithImpl<$Res, $Val extends LatestCheckIn>
    implements $LatestCheckInCopyWith<$Res> {
  _$LatestCheckInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatestCheckIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latestCheckedAt = freezed, Object? todayChecked = null}) {
    return _then(
      _value.copyWith(
            latestCheckedAt: freezed == latestCheckedAt
                ? _value.latestCheckedAt
                : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            todayChecked: null == todayChecked
                ? _value.todayChecked
                : todayChecked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LatestCheckInImplCopyWith<$Res>
    implements $LatestCheckInCopyWith<$Res> {
  factory _$$LatestCheckInImplCopyWith(
    _$LatestCheckInImpl value,
    $Res Function(_$LatestCheckInImpl) then,
  ) = __$$LatestCheckInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? latestCheckedAt, bool todayChecked});
}

/// @nodoc
class __$$LatestCheckInImplCopyWithImpl<$Res>
    extends _$LatestCheckInCopyWithImpl<$Res, _$LatestCheckInImpl>
    implements _$$LatestCheckInImplCopyWith<$Res> {
  __$$LatestCheckInImplCopyWithImpl(
    _$LatestCheckInImpl _value,
    $Res Function(_$LatestCheckInImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LatestCheckIn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? latestCheckedAt = freezed, Object? todayChecked = null}) {
    return _then(
      _$LatestCheckInImpl(
        latestCheckedAt: freezed == latestCheckedAt
            ? _value.latestCheckedAt
            : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        todayChecked: null == todayChecked
            ? _value.todayChecked
            : todayChecked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$LatestCheckInImpl implements _LatestCheckIn {
  const _$LatestCheckInImpl({this.latestCheckedAt, required this.todayChecked});

  @override
  final DateTime? latestCheckedAt;
  @override
  final bool todayChecked;

  @override
  String toString() {
    return 'LatestCheckIn(latestCheckedAt: $latestCheckedAt, todayChecked: $todayChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatestCheckInImpl &&
            (identical(other.latestCheckedAt, latestCheckedAt) ||
                other.latestCheckedAt == latestCheckedAt) &&
            (identical(other.todayChecked, todayChecked) ||
                other.todayChecked == todayChecked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latestCheckedAt, todayChecked);

  /// Create a copy of LatestCheckIn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatestCheckInImplCopyWith<_$LatestCheckInImpl> get copyWith =>
      __$$LatestCheckInImplCopyWithImpl<_$LatestCheckInImpl>(this, _$identity);
}

abstract class _LatestCheckIn implements LatestCheckIn {
  const factory _LatestCheckIn({
    final DateTime? latestCheckedAt,
    required final bool todayChecked,
  }) = _$LatestCheckInImpl;

  @override
  DateTime? get latestCheckedAt;
  @override
  bool get todayChecked;

  /// Create a copy of LatestCheckIn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatestCheckInImplCopyWith<_$LatestCheckInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
