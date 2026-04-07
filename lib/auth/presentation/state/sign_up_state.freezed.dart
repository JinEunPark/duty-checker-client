// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpState {
  bool get isSendingCode => throw _privateConstructorUsedError;
  bool get isVerifyingCode => throw _privateConstructorUsedError;
  bool get isRegistering => throw _privateConstructorUsedError;
  bool get codeSent => throw _privateConstructorUsedError;
  bool get codeVerified => throw _privateConstructorUsedError;
  bool get registered => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignUpStateCopyWith<SignUpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpStateCopyWith<$Res> {
  factory $SignUpStateCopyWith(
          SignUpState value, $Res Function(SignUpState) then) =
      _$SignUpStateCopyWithImpl<$Res, SignUpState>;
  @useResult
  $Res call(
      {bool isSendingCode,
      bool isVerifyingCode,
      bool isRegistering,
      bool codeSent,
      bool codeVerified,
      bool registered,
      String? error});
}

/// @nodoc
class _$SignUpStateCopyWithImpl<$Res, $Val extends SignUpState>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSendingCode = null,
    Object? isVerifyingCode = null,
    Object? isRegistering = null,
    Object? codeSent = null,
    Object? codeVerified = null,
    Object? registered = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isSendingCode: null == isSendingCode
          ? _value.isSendingCode
          : isSendingCode // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerifyingCode: null == isVerifyingCode
          ? _value.isVerifyingCode
          : isVerifyingCode // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegistering: null == isRegistering
          ? _value.isRegistering
          : isRegistering // ignore: cast_nullable_to_non_nullable
              as bool,
      codeSent: null == codeSent
          ? _value.codeSent
          : codeSent // ignore: cast_nullable_to_non_nullable
              as bool,
      codeVerified: null == codeVerified
          ? _value.codeVerified
          : codeVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpStateImplCopyWith<$Res>
    implements $SignUpStateCopyWith<$Res> {
  factory _$$SignUpStateImplCopyWith(
          _$SignUpStateImpl value, $Res Function(_$SignUpStateImpl) then) =
      __$$SignUpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSendingCode,
      bool isVerifyingCode,
      bool isRegistering,
      bool codeSent,
      bool codeVerified,
      bool registered,
      String? error});
}

/// @nodoc
class __$$SignUpStateImplCopyWithImpl<$Res>
    extends _$SignUpStateCopyWithImpl<$Res, _$SignUpStateImpl>
    implements _$$SignUpStateImplCopyWith<$Res> {
  __$$SignUpStateImplCopyWithImpl(
      _$SignUpStateImpl _value, $Res Function(_$SignUpStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSendingCode = null,
    Object? isVerifyingCode = null,
    Object? isRegistering = null,
    Object? codeSent = null,
    Object? codeVerified = null,
    Object? registered = null,
    Object? error = freezed,
  }) {
    return _then(_$SignUpStateImpl(
      isSendingCode: null == isSendingCode
          ? _value.isSendingCode
          : isSendingCode // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerifyingCode: null == isVerifyingCode
          ? _value.isVerifyingCode
          : isVerifyingCode // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegistering: null == isRegistering
          ? _value.isRegistering
          : isRegistering // ignore: cast_nullable_to_non_nullable
              as bool,
      codeSent: null == codeSent
          ? _value.codeSent
          : codeSent // ignore: cast_nullable_to_non_nullable
              as bool,
      codeVerified: null == codeVerified
          ? _value.codeVerified
          : codeVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SignUpStateImpl implements _SignUpState {
  const _$SignUpStateImpl(
      {this.isSendingCode = false,
      this.isVerifyingCode = false,
      this.isRegistering = false,
      this.codeSent = false,
      this.codeVerified = false,
      this.registered = false,
      this.error});

  @override
  @JsonKey()
  final bool isSendingCode;
  @override
  @JsonKey()
  final bool isVerifyingCode;
  @override
  @JsonKey()
  final bool isRegistering;
  @override
  @JsonKey()
  final bool codeSent;
  @override
  @JsonKey()
  final bool codeVerified;
  @override
  @JsonKey()
  final bool registered;
  @override
  final String? error;

  @override
  String toString() {
    return 'SignUpState(isSendingCode: $isSendingCode, isVerifyingCode: $isVerifyingCode, isRegistering: $isRegistering, codeSent: $codeSent, codeVerified: $codeVerified, registered: $registered, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpStateImpl &&
            (identical(other.isSendingCode, isSendingCode) ||
                other.isSendingCode == isSendingCode) &&
            (identical(other.isVerifyingCode, isVerifyingCode) ||
                other.isVerifyingCode == isVerifyingCode) &&
            (identical(other.isRegistering, isRegistering) ||
                other.isRegistering == isRegistering) &&
            (identical(other.codeSent, codeSent) ||
                other.codeSent == codeSent) &&
            (identical(other.codeVerified, codeVerified) ||
                other.codeVerified == codeVerified) &&
            (identical(other.registered, registered) ||
                other.registered == registered) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSendingCode, isVerifyingCode,
      isRegistering, codeSent, codeVerified, registered, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      __$$SignUpStateImplCopyWithImpl<_$SignUpStateImpl>(this, _$identity);
}

abstract class _SignUpState implements SignUpState {
  const factory _SignUpState(
      {final bool isSendingCode,
      final bool isVerifyingCode,
      final bool isRegistering,
      final bool codeSent,
      final bool codeVerified,
      final bool registered,
      final String? error}) = _$SignUpStateImpl;

  @override
  bool get isSendingCode;
  @override
  bool get isVerifyingCode;
  @override
  bool get isRegistering;
  @override
  bool get codeSent;
  @override
  bool get codeVerified;
  @override
  bool get registered;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SignUpStateImplCopyWith<_$SignUpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
