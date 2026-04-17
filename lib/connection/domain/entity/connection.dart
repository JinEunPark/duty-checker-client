import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection.freezed.dart';

enum ConnectionStatus { pending, connected }

@freezed
class Connection with _$Connection {
  const Connection._();

  const factory Connection({
    required int id,
    required String phone,
    required String name,
    required ConnectionStatus status,
    DateTime? latestCheckedAt,
    required bool isTodayChecked,
    UserRole? requesterRole,
  }) = _Connection;

  bool get isPending => status == ConnectionStatus.pending;
  bool get isConnected => status == ConnectionStatus.connected;
}

@freezed
class ConnectionList with _$ConnectionList {
  const factory ConnectionList({
    required UserRole role,
    required List<Connection> connections,
  }) = _ConnectionList;
}

extension ConnectionStatusMapper on ConnectionStatus {
  static ConnectionStatus fromString(String? value) {
    return value?.toUpperCase() == 'PENDING'
        ? ConnectionStatus.pending
        : ConnectionStatus.connected;
  }
}