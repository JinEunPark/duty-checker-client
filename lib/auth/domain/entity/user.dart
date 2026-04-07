import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

enum UserRole { subject, guardian }

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String phone,
    required UserRole role,
  }) = _User;

  bool get isSubject => role == UserRole.subject;
  bool get isGuardian => role == UserRole.guardian;
}

extension UserRoleMapper on UserRole {
  static UserRole fromString(String? value) {
    return value?.toUpperCase() == 'GUARDIAN'
        ? UserRole.guardian
        : UserRole.subject;
  }
}
