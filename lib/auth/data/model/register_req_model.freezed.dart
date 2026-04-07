// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegisterReqModel _$RegisterReqModelFromJson(Map<String, dynamic> json) {
  return _RegisterReqModel.fromJson(json);
}

/// @nodoc
mixin _$RegisterReqModel {
  String get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterReqModelCopyWith<RegisterReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterReqModelCopyWith<$Res> {
  factory $RegisterReqModelCopyWith(
          RegisterReqModel value, $Res Function(RegisterReqModel) then) =
      _$RegisterReqModelCopyWithImpl<$Res, RegisterReqModel>;
  @useResult
  $Res call({String phone, String password, String role});
}

/// @nodoc
class _$RegisterReqModelCopyWithImpl<$Res, $Val extends RegisterReqModel>
    implements $RegisterReqModelCopyWith<$Res> {
  _$RegisterReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterReqModelImplCopyWith<$Res>
    implements $RegisterReqModelCopyWith<$Res> {
  factory _$$RegisterReqModelImplCopyWith(_$RegisterReqModelImpl value,
          $Res Function(_$RegisterReqModelImpl) then) =
      __$$RegisterReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String password, String role});
}

/// @nodoc
class __$$RegisterReqModelImplCopyWithImpl<$Res>
    extends _$RegisterReqModelCopyWithImpl<$Res, _$RegisterReqModelImpl>
    implements _$$RegisterReqModelImplCopyWith<$Res> {
  __$$RegisterReqModelImplCopyWithImpl(_$RegisterReqModelImpl _value,
      $Res Function(_$RegisterReqModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
    Object? role = null,
  }) {
    return _then(_$RegisterReqModelImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterReqModelImpl implements _RegisterReqModel {
  const _$RegisterReqModelImpl(
      {required this.phone, required this.password, required this.role});

  factory _$RegisterReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterReqModelImplFromJson(json);

  @override
  final String phone;
  @override
  final String password;
  @override
  final String role;

  @override
  String toString() {
    return 'RegisterReqModel(phone: $phone, password: $password, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterReqModelImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone, password, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterReqModelImplCopyWith<_$RegisterReqModelImpl> get copyWith =>
      __$$RegisterReqModelImplCopyWithImpl<_$RegisterReqModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterReqModelImplToJson(
      this,
    );
  }
}

abstract class _RegisterReqModel implements RegisterReqModel {
  const factory _RegisterReqModel(
      {required final String phone,
      required final String password,
      required final String role}) = _$RegisterReqModelImpl;

  factory _RegisterReqModel.fromJson(Map<String, dynamic> json) =
      _$RegisterReqModelImpl.fromJson;

  @override
  String get phone;
  @override
  String get password;
  @override
  String get role;
  @override
  @JsonKey(ignore: true)
  _$$RegisterReqModelImplCopyWith<_$RegisterReqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
