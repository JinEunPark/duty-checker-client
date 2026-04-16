// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ResetPasswordState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get codeSent => throw _privateConstructorUsedError;
  DateTime? get codeExpiresAt => throw _privateConstructorUsedError;
  bool get codeVerified => throw _privateConstructorUsedError;
  bool get passwordReset => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordStateCopyWith<ResetPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordStateCopyWith(
    ResetPasswordState value,
    $Res Function(ResetPasswordState) then,
  ) = _$ResetPasswordStateCopyWithImpl<$Res, ResetPasswordState>;
  @useResult
  $Res call({
    bool isLoading,
    bool codeSent,
    DateTime? codeExpiresAt,
    bool codeVerified,
    bool passwordReset,
    String? error,
  });
}

/// @nodoc
class _$ResetPasswordStateCopyWithImpl<$Res, $Val extends ResetPasswordState>
    implements $ResetPasswordStateCopyWith<$Res> {
  _$ResetPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? codeSent = null,
    Object? codeExpiresAt = freezed,
    Object? codeVerified = null,
    Object? passwordReset = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            codeSent: null == codeSent
                ? _value.codeSent
                : codeSent // ignore: cast_nullable_to_non_nullable
                      as bool,
            codeExpiresAt: freezed == codeExpiresAt
                ? _value.codeExpiresAt
                : codeExpiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            codeVerified: null == codeVerified
                ? _value.codeVerified
                : codeVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            passwordReset: null == passwordReset
                ? _value.passwordReset
                : passwordReset // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResetPasswordStateImplCopyWith<$Res>
    implements $ResetPasswordStateCopyWith<$Res> {
  factory _$$ResetPasswordStateImplCopyWith(
    _$ResetPasswordStateImpl value,
    $Res Function(_$ResetPasswordStateImpl) then,
  ) = __$$ResetPasswordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool codeSent,
    DateTime? codeExpiresAt,
    bool codeVerified,
    bool passwordReset,
    String? error,
  });
}

/// @nodoc
class __$$ResetPasswordStateImplCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res, _$ResetPasswordStateImpl>
    implements _$$ResetPasswordStateImplCopyWith<$Res> {
  __$$ResetPasswordStateImplCopyWithImpl(
    _$ResetPasswordStateImpl _value,
    $Res Function(_$ResetPasswordStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? codeSent = null,
    Object? codeExpiresAt = freezed,
    Object? codeVerified = null,
    Object? passwordReset = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ResetPasswordStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        codeSent: null == codeSent
            ? _value.codeSent
            : codeSent // ignore: cast_nullable_to_non_nullable
                  as bool,
        codeExpiresAt: freezed == codeExpiresAt
            ? _value.codeExpiresAt
            : codeExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        codeVerified: null == codeVerified
            ? _value.codeVerified
            : codeVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        passwordReset: null == passwordReset
            ? _value.passwordReset
            : passwordReset // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ResetPasswordStateImpl implements _ResetPasswordState {
  const _$ResetPasswordStateImpl({
    this.isLoading = false,
    this.codeSent = false,
    this.codeExpiresAt,
    this.codeVerified = false,
    this.passwordReset = false,
    this.error,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool codeSent;
  @override
  final DateTime? codeExpiresAt;
  @override
  @JsonKey()
  final bool codeVerified;
  @override
  @JsonKey()
  final bool passwordReset;
  @override
  final String? error;

  @override
  String toString() {
    return 'ResetPasswordState(isLoading: $isLoading, codeSent: $codeSent, codeExpiresAt: $codeExpiresAt, codeVerified: $codeVerified, passwordReset: $passwordReset, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.codeSent, codeSent) ||
                other.codeSent == codeSent) &&
            (identical(other.codeExpiresAt, codeExpiresAt) ||
                other.codeExpiresAt == codeExpiresAt) &&
            (identical(other.codeVerified, codeVerified) ||
                other.codeVerified == codeVerified) &&
            (identical(other.passwordReset, passwordReset) ||
                other.passwordReset == passwordReset) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    codeSent,
    codeExpiresAt,
    codeVerified,
    passwordReset,
    error,
  );

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordStateImplCopyWith<_$ResetPasswordStateImpl> get copyWith =>
      __$$ResetPasswordStateImplCopyWithImpl<_$ResetPasswordStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ResetPasswordState implements ResetPasswordState {
  const factory _ResetPasswordState({
    final bool isLoading,
    final bool codeSent,
    final DateTime? codeExpiresAt,
    final bool codeVerified,
    final bool passwordReset,
    final String? error,
  }) = _$ResetPasswordStateImpl;

  @override
  bool get isLoading;
  @override
  bool get codeSent;
  @override
  DateTime? get codeExpiresAt;
  @override
  bool get codeVerified;
  @override
  bool get passwordReset;
  @override
  String? get error;

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordStateImplCopyWith<_$ResetPasswordStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
