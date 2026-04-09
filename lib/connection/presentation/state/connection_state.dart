import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_state.freezed.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState({
    @Default(false) bool isLoading,
    @Default([]) List<Connection> connections,
    String? error,
  }) = _ConnectionState;
}
