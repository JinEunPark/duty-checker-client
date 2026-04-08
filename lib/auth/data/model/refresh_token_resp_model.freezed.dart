// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_token_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RefreshTokenRespModel _$RefreshTokenRespModelFromJson(
  Map<String, dynamic> json,
) {
  return _RefreshTokenRespModel.fromJson(json);
}

/// @nodoc
mixin _$RefreshTokenRespModel {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this RefreshTokenRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RefreshTokenRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefreshTokenRespModelCopyWith<RefreshTokenRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshTokenRespModelCopyWith<$Res> {
  factory $RefreshTokenRespModelCopyWith(
    RefreshTokenRespModel value,
    $Res Function(RefreshTokenRespModel) then,
  ) = _$RefreshTokenRespModelCopyWithImpl<$Res, RefreshTokenRespModel>;
  @useResult
  $Res call({String? accessToken, String? refreshToken});
}

/// @nodoc
class _$RefreshTokenRespModelCopyWithImpl<
  $Res,
  $Val extends RefreshTokenRespModel
>
    implements $RefreshTokenRespModelCopyWith<$Res> {
  _$RefreshTokenRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefreshTokenRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = freezed, Object? refreshToken = freezed}) {
    return _then(
      _value.copyWith(
            accessToken: freezed == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            refreshToken: freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RefreshTokenRespModelImplCopyWith<$Res>
    implements $RefreshTokenRespModelCopyWith<$Res> {
  factory _$$RefreshTokenRespModelImplCopyWith(
    _$RefreshTokenRespModelImpl value,
    $Res Function(_$RefreshTokenRespModelImpl) then,
  ) = __$$RefreshTokenRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken, String? refreshToken});
}

/// @nodoc
class __$$RefreshTokenRespModelImplCopyWithImpl<$Res>
    extends
        _$RefreshTokenRespModelCopyWithImpl<$Res, _$RefreshTokenRespModelImpl>
    implements _$$RefreshTokenRespModelImplCopyWith<$Res> {
  __$$RefreshTokenRespModelImplCopyWithImpl(
    _$RefreshTokenRespModelImpl _value,
    $Res Function(_$RefreshTokenRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RefreshTokenRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = freezed, Object? refreshToken = freezed}) {
    return _then(
      _$RefreshTokenRespModelImpl(
        accessToken: freezed == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshTokenRespModelImpl implements _RefreshTokenRespModel {
  const _$RefreshTokenRespModelImpl({this.accessToken, this.refreshToken});

  factory _$RefreshTokenRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshTokenRespModelImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'RefreshTokenRespModel(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTokenRespModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  /// Create a copy of RefreshTokenRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTokenRespModelImplCopyWith<_$RefreshTokenRespModelImpl>
  get copyWith =>
      __$$RefreshTokenRespModelImplCopyWithImpl<_$RefreshTokenRespModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshTokenRespModelImplToJson(this);
  }
}

abstract class _RefreshTokenRespModel implements RefreshTokenRespModel {
  const factory _RefreshTokenRespModel({
    final String? accessToken,
    final String? refreshToken,
  }) = _$RefreshTokenRespModelImpl;

  factory _RefreshTokenRespModel.fromJson(Map<String, dynamic> json) =
      _$RefreshTokenRespModelImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get refreshToken;

  /// Create a copy of RefreshTokenRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTokenRespModelImplCopyWith<_$RefreshTokenRespModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
