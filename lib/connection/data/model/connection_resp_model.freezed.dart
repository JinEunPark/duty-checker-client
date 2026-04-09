// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConnectionRespModel _$ConnectionRespModelFromJson(Map<String, dynamic> json) {
  return _ConnectionRespModel.fromJson(json);
}

/// @nodoc
mixin _$ConnectionRespModel {
  int? get id => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get latestCheckedAt => throw _privateConstructorUsedError;
  bool? get isTodayChecked => throw _privateConstructorUsedError;

  /// Serializes this ConnectionRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionRespModelCopyWith<ConnectionRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionRespModelCopyWith<$Res> {
  factory $ConnectionRespModelCopyWith(
    ConnectionRespModel value,
    $Res Function(ConnectionRespModel) then,
  ) = _$ConnectionRespModelCopyWithImpl<$Res, ConnectionRespModel>;
  @useResult
  $Res call({
    int? id,
    String? phone,
    String? name,
    String? status,
    String? latestCheckedAt,
    bool? isTodayChecked,
  });
}

/// @nodoc
class _$ConnectionRespModelCopyWithImpl<$Res, $Val extends ConnectionRespModel>
    implements $ConnectionRespModelCopyWith<$Res> {
  _$ConnectionRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phone = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? latestCheckedAt = freezed,
    Object? isTodayChecked = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            latestCheckedAt: freezed == latestCheckedAt
                ? _value.latestCheckedAt
                : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            isTodayChecked: freezed == isTodayChecked
                ? _value.isTodayChecked
                : isTodayChecked // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionRespModelImplCopyWith<$Res>
    implements $ConnectionRespModelCopyWith<$Res> {
  factory _$$ConnectionRespModelImplCopyWith(
    _$ConnectionRespModelImpl value,
    $Res Function(_$ConnectionRespModelImpl) then,
  ) = __$$ConnectionRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String? phone,
    String? name,
    String? status,
    String? latestCheckedAt,
    bool? isTodayChecked,
  });
}

/// @nodoc
class __$$ConnectionRespModelImplCopyWithImpl<$Res>
    extends _$ConnectionRespModelCopyWithImpl<$Res, _$ConnectionRespModelImpl>
    implements _$$ConnectionRespModelImplCopyWith<$Res> {
  __$$ConnectionRespModelImplCopyWithImpl(
    _$ConnectionRespModelImpl _value,
    $Res Function(_$ConnectionRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phone = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? latestCheckedAt = freezed,
    Object? isTodayChecked = freezed,
  }) {
    return _then(
      _$ConnectionRespModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        latestCheckedAt: freezed == latestCheckedAt
            ? _value.latestCheckedAt
            : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        isTodayChecked: freezed == isTodayChecked
            ? _value.isTodayChecked
            : isTodayChecked // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionRespModelImpl implements _ConnectionRespModel {
  const _$ConnectionRespModelImpl({
    this.id,
    this.phone,
    this.name,
    this.status,
    this.latestCheckedAt,
    this.isTodayChecked,
  });

  factory _$ConnectionRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionRespModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? phone;
  @override
  final String? name;
  @override
  final String? status;
  @override
  final String? latestCheckedAt;
  @override
  final bool? isTodayChecked;

  @override
  String toString() {
    return 'ConnectionRespModel(id: $id, phone: $phone, name: $name, status: $status, latestCheckedAt: $latestCheckedAt, isTodayChecked: $isTodayChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionRespModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latestCheckedAt, latestCheckedAt) ||
                other.latestCheckedAt == latestCheckedAt) &&
            (identical(other.isTodayChecked, isTodayChecked) ||
                other.isTodayChecked == isTodayChecked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ConnectionRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionRespModelImplCopyWith<_$ConnectionRespModelImpl> get copyWith =>
      __$$ConnectionRespModelImplCopyWithImpl<_$ConnectionRespModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionRespModelImplToJson(this);
  }
}

abstract class _ConnectionRespModel implements ConnectionRespModel {
  const factory _ConnectionRespModel({
    final int? id,
    final String? phone,
    final String? name,
    final String? status,
    final String? latestCheckedAt,
    final bool? isTodayChecked,
  }) = _$ConnectionRespModelImpl;

  factory _ConnectionRespModel.fromJson(Map<String, dynamic> json) =
      _$ConnectionRespModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get phone;
  @override
  String? get name;
  @override
  String? get status;
  @override
  String? get latestCheckedAt;
  @override
  bool? get isTodayChecked;

  /// Create a copy of ConnectionRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionRespModelImplCopyWith<_$ConnectionRespModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
