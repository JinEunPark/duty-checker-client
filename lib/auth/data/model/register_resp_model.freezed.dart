// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_resp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegisterRespModel _$RegisterRespModelFromJson(Map<String, dynamic> json) {
  return _RegisterRespModel.fromJson(json);
}

/// @nodoc
mixin _$RegisterRespModel {
  int? get id => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterRespModelCopyWith<RegisterRespModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRespModelCopyWith<$Res> {
  factory $RegisterRespModelCopyWith(
          RegisterRespModel value, $Res Function(RegisterRespModel) then) =
      _$RegisterRespModelCopyWithImpl<$Res, RegisterRespModel>;
  @useResult
  $Res call({int? id, String? phone, String? role});
}

/// @nodoc
class _$RegisterRespModelCopyWithImpl<$Res, $Val extends RegisterRespModel>
    implements $RegisterRespModelCopyWith<$Res> {
  _$RegisterRespModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phone = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterRespModelImplCopyWith<$Res>
    implements $RegisterRespModelCopyWith<$Res> {
  factory _$$RegisterRespModelImplCopyWith(_$RegisterRespModelImpl value,
          $Res Function(_$RegisterRespModelImpl) then) =
      __$$RegisterRespModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? phone, String? role});
}

/// @nodoc
class __$$RegisterRespModelImplCopyWithImpl<$Res>
    extends _$RegisterRespModelCopyWithImpl<$Res, _$RegisterRespModelImpl>
    implements _$$RegisterRespModelImplCopyWith<$Res> {
  __$$RegisterRespModelImplCopyWithImpl(_$RegisterRespModelImpl _value,
      $Res Function(_$RegisterRespModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phone = freezed,
    Object? role = freezed,
  }) {
    return _then(_$RegisterRespModelImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRespModelImpl implements _RegisterRespModel {
  const _$RegisterRespModelImpl({this.id, this.phone, this.role});

  factory _$RegisterRespModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRespModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? phone;
  @override
  final String? role;

  @override
  String toString() {
    return 'RegisterRespModel(id: $id, phone: $phone, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRespModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, phone, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRespModelImplCopyWith<_$RegisterRespModelImpl> get copyWith =>
      __$$RegisterRespModelImplCopyWithImpl<_$RegisterRespModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRespModelImplToJson(
      this,
    );
  }
}

abstract class _RegisterRespModel implements RegisterRespModel {
  const factory _RegisterRespModel(
      {final int? id,
      final String? phone,
      final String? role}) = _$RegisterRespModelImpl;

  factory _RegisterRespModel.fromJson(Map<String, dynamic> json) =
      _$RegisterRespModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get phone;
  @override
  String? get role;
  @override
  @JsonKey(ignore: true)
  _$$RegisterRespModelImplCopyWith<_$RegisterRespModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
