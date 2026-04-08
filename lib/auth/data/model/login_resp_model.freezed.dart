// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginRespModel _$LoginRespModelFromJson(Map<String, dynamic> json) {
  return _LoginRespModel.fromJson(json);
}

/// @nodoc
mixin _$LoginRespModel {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  UserInfoModel? get user => throw _privateConstructorUsedError;

  /// Serializes this LoginRespModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRespModelCopyWith<LoginRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRespModelCopyWith<$Res> {
  factory $LoginRespModelCopyWith(
    LoginRespModel value,
    $Res Function(LoginRespModel) then,
  ) = _$LoginRespModelCopyWithImpl<$Res, LoginRespModel>;
  @useResult
  $Res call({String? accessToken, String? refreshToken, UserInfoModel? user});

  $UserInfoModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$LoginRespModelCopyWithImpl<$Res, $Val extends LoginRespModel>
    implements $LoginRespModelCopyWith<$Res> {
  _$LoginRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? user = freezed,
  }) {
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
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserInfoModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserInfoModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginRespModelImplCopyWith<$Res>
    implements $LoginRespModelCopyWith<$Res> {
  factory _$$LoginRespModelImplCopyWith(
    _$LoginRespModelImpl value,
    $Res Function(_$LoginRespModelImpl) then,
  ) = __$$LoginRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken, String? refreshToken, UserInfoModel? user});

  @override
  $UserInfoModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$LoginRespModelImplCopyWithImpl<$Res>
    extends _$LoginRespModelCopyWithImpl<$Res, _$LoginRespModelImpl>
    implements _$$LoginRespModelImplCopyWith<$Res> {
  __$$LoginRespModelImplCopyWithImpl(
    _$LoginRespModelImpl _value,
    $Res Function(_$LoginRespModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRespModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _$LoginRespModelImpl(
        accessToken: freezed == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserInfoModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRespModelImpl implements _LoginRespModel {
  const _$LoginRespModelImpl({this.accessToken, this.refreshToken, this.user});

  factory _$LoginRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRespModelImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final UserInfoModel? user;

  @override
  String toString() {
    return 'LoginRespModel(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRespModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken, user);

  /// Create a copy of LoginRespModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRespModelImplCopyWith<_$LoginRespModelImpl> get copyWith =>
      __$$LoginRespModelImplCopyWithImpl<_$LoginRespModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRespModelImplToJson(this);
  }
}

abstract class _LoginRespModel implements LoginRespModel {
  const factory _LoginRespModel({
    final String? accessToken,
    final String? refreshToken,
    final UserInfoModel? user,
  }) = _$LoginRespModelImpl;

  factory _LoginRespModel.fromJson(Map<String, dynamic> json) =
      _$LoginRespModelImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  UserInfoModel? get user;

  /// Create a copy of LoginRespModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRespModelImplCopyWith<_$LoginRespModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return _UserInfoModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoModel {
  int? get id => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  /// Serializes this UserInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoModelCopyWith<UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoModelCopyWith<$Res> {
  factory $UserInfoModelCopyWith(
    UserInfoModel value,
    $Res Function(UserInfoModel) then,
  ) = _$UserInfoModelCopyWithImpl<$Res, UserInfoModel>;
  @useResult
  $Res call({int? id, String? phone, String? role});
}

/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res, $Val extends UserInfoModel>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phone = freezed,
    Object? role = freezed,
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
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserInfoModelImplCopyWith<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  factory _$$UserInfoModelImplCopyWith(
    _$UserInfoModelImpl value,
    $Res Function(_$UserInfoModelImpl) then,
  ) = __$$UserInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? phone, String? role});
}

/// @nodoc
class __$$UserInfoModelImplCopyWithImpl<$Res>
    extends _$UserInfoModelCopyWithImpl<$Res, _$UserInfoModelImpl>
    implements _$$UserInfoModelImplCopyWith<$Res> {
  __$$UserInfoModelImplCopyWithImpl(
    _$UserInfoModelImpl _value,
    $Res Function(_$UserInfoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phone = freezed,
    Object? role = freezed,
  }) {
    return _then(
      _$UserInfoModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoModelImpl implements _UserInfoModel {
  const _$UserInfoModelImpl({this.id, this.phone, this.role});

  factory _$UserInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? phone;
  @override
  final String? role;

  @override
  String toString() {
    return 'UserInfoModel(id: $id, phone: $phone, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, phone, role);

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      __$$UserInfoModelImplCopyWithImpl<_$UserInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoModelImplToJson(this);
  }
}

abstract class _UserInfoModel implements UserInfoModel {
  const factory _UserInfoModel({
    final int? id,
    final String? phone,
    final String? role,
  }) = _$UserInfoModelImpl;

  factory _UserInfoModel.fromJson(Map<String, dynamic> json) =
      _$UserInfoModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get phone;
  @override
  String? get role;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
