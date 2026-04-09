// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_latest_check_in_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GetLatestCheckInRespModel _$GetLatestCheckInRespModelFromJson(
  Map<String, dynamic> json,
) {
  return _GetLatestCheckInRespModel.fromJson(json);
}

/// @nodoc
mixin _$GetLatestCheckInRespModel {
  String? get latestCheckedAt => throw _privateConstructorUsedError;
  bool? get todayChecked => throw _privateConstructorUsedError;

  /// Serializes this GetLatestCheckInRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetLatestCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetLatestCheckInRespModelCopyWith<GetLatestCheckInRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetLatestCheckInRespModelCopyWith<$Res> {
  factory $GetLatestCheckInRespModelCopyWith(
    GetLatestCheckInRespModel value,
    $Res Function(GetLatestCheckInRespModel) then,
  ) = _$GetLatestCheckInRespModelCopyWithImpl<$Res, GetLatestCheckInRespModel>;
  @useResult
  $Res call({String? latestCheckedAt, bool? todayChecked});
}

/// @nodoc
class _$GetLatestCheckInRespModelCopyWithImpl<
  $Res,
  $Val extends GetLatestCheckInRespModel
>
    implements $GetLatestCheckInRespModelCopyWith<$Res> {
  _$GetLatestCheckInRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetLatestCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latestCheckedAt = freezed,
    Object? todayChecked = freezed,
  }) {
    return _then(
      _value.copyWith(
            latestCheckedAt: freezed == latestCheckedAt
                ? _value.latestCheckedAt
                : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            todayChecked: freezed == todayChecked
                ? _value.todayChecked
                : todayChecked // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetLatestCheckInRespModelImplCopyWith<$Res>
    implements $GetLatestCheckInRespModelCopyWith<$Res> {
  factory _$$GetLatestCheckInRespModelImplCopyWith(
    _$GetLatestCheckInRespModelImpl value,
    $Res Function(_$GetLatestCheckInRespModelImpl) then,
  ) = __$$GetLatestCheckInRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? latestCheckedAt, bool? todayChecked});
}

/// @nodoc
class __$$GetLatestCheckInRespModelImplCopyWithImpl<$Res>
    extends
        _$GetLatestCheckInRespModelCopyWithImpl<
          $Res,
          _$GetLatestCheckInRespModelImpl
        >
    implements _$$GetLatestCheckInRespModelImplCopyWith<$Res> {
  __$$GetLatestCheckInRespModelImplCopyWithImpl(
    _$GetLatestCheckInRespModelImpl _value,
    $Res Function(_$GetLatestCheckInRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GetLatestCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latestCheckedAt = freezed,
    Object? todayChecked = freezed,
  }) {
    return _then(
      _$GetLatestCheckInRespModelImpl(
        latestCheckedAt: freezed == latestCheckedAt
            ? _value.latestCheckedAt
            : latestCheckedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        todayChecked: freezed == todayChecked
            ? _value.todayChecked
            : todayChecked // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GetLatestCheckInRespModelImpl implements _GetLatestCheckInRespModel {
  const _$GetLatestCheckInRespModelImpl({
    this.latestCheckedAt,
    this.todayChecked,
  });

  factory _$GetLatestCheckInRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetLatestCheckInRespModelImplFromJson(json);

  @override
  final String? latestCheckedAt;
  @override
  final bool? todayChecked;

  @override
  String toString() {
    return 'GetLatestCheckInRespModel(latestCheckedAt: $latestCheckedAt, todayChecked: $todayChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetLatestCheckInRespModelImpl &&
            (identical(other.latestCheckedAt, latestCheckedAt) ||
                other.latestCheckedAt == latestCheckedAt) &&
            (identical(other.todayChecked, todayChecked) ||
                other.todayChecked == todayChecked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latestCheckedAt, todayChecked);

  /// Create a copy of GetLatestCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetLatestCheckInRespModelImplCopyWith<_$GetLatestCheckInRespModelImpl>
  get copyWith =>
      __$$GetLatestCheckInRespModelImplCopyWithImpl<
        _$GetLatestCheckInRespModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetLatestCheckInRespModelImplToJson(this);
  }
}

abstract class _GetLatestCheckInRespModel implements GetLatestCheckInRespModel {
  const factory _GetLatestCheckInRespModel({
    final String? latestCheckedAt,
    final bool? todayChecked,
  }) = _$GetLatestCheckInRespModelImpl;

  factory _GetLatestCheckInRespModel.fromJson(Map<String, dynamic> json) =
      _$GetLatestCheckInRespModelImpl.fromJson;

  @override
  String? get latestCheckedAt;
  @override
  bool? get todayChecked;

  /// Create a copy of GetLatestCheckInRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetLatestCheckInRespModelImplCopyWith<_$GetLatestCheckInRespModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
