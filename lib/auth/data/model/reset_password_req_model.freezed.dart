// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ResetPasswordReqModel _$ResetPasswordReqModelFromJson(
  Map<String, dynamic> json,
) {
  return _ResetPasswordReqModel.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordReqModel {
  String get phone => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordReqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordReqModelCopyWith<ResetPasswordReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordReqModelCopyWith<$Res> {
  factory $ResetPasswordReqModelCopyWith(
    ResetPasswordReqModel value,
    $Res Function(ResetPasswordReqModel) then,
  ) = _$ResetPasswordReqModelCopyWithImpl<$Res, ResetPasswordReqModel>;
  @useResult
  $Res call({String phone, String newPassword});
}

/// @nodoc
class _$ResetPasswordReqModelCopyWithImpl<
  $Res,
  $Val extends ResetPasswordReqModel
>
    implements $ResetPasswordReqModelCopyWith<$Res> {
  _$ResetPasswordReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phone = null, Object? newPassword = null}) {
    return _then(
      _value.copyWith(
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            newPassword: null == newPassword
                ? _value.newPassword
                : newPassword // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResetPasswordReqModelImplCopyWith<$Res>
    implements $ResetPasswordReqModelCopyWith<$Res> {
  factory _$$ResetPasswordReqModelImplCopyWith(
    _$ResetPasswordReqModelImpl value,
    $Res Function(_$ResetPasswordReqModelImpl) then,
  ) = __$$ResetPasswordReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String newPassword});
}

/// @nodoc
class __$$ResetPasswordReqModelImplCopyWithImpl<$Res>
    extends
        _$ResetPasswordReqModelCopyWithImpl<$Res, _$ResetPasswordReqModelImpl>
    implements _$$ResetPasswordReqModelImplCopyWith<$Res> {
  __$$ResetPasswordReqModelImplCopyWithImpl(
    _$ResetPasswordReqModelImpl _value,
    $Res Function(_$ResetPasswordReqModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phone = null, Object? newPassword = null}) {
    return _then(
      _$ResetPasswordReqModelImpl(
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordReqModelImpl implements _ResetPasswordReqModel {
  const _$ResetPasswordReqModelImpl({
    required this.phone,
    required this.newPassword,
  });

  factory _$ResetPasswordReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordReqModelImplFromJson(json);

  @override
  final String phone;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ResetPasswordReqModel(phone: $phone, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordReqModelImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone, newPassword);

  /// Create a copy of ResetPasswordReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordReqModelImplCopyWith<_$ResetPasswordReqModelImpl>
  get copyWith =>
      __$$ResetPasswordReqModelImplCopyWithImpl<_$ResetPasswordReqModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordReqModelImplToJson(this);
  }
}

abstract class _ResetPasswordReqModel implements ResetPasswordReqModel {
  const factory _ResetPasswordReqModel({
    required final String phone,
    required final String newPassword,
  }) = _$ResetPasswordReqModelImpl;

  factory _ResetPasswordReqModel.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordReqModelImpl.fromJson;

  @override
  String get phone;
  @override
  String get newPassword;

  /// Create a copy of ResetPasswordReqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordReqModelImplCopyWith<_$ResetPasswordReqModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
