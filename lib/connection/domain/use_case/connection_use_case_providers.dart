import 'package:duty_checker/connection/data/repository/connection_repository_impl.dart';
import 'package:duty_checker/connection/domain/use_case/accept_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/add_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/delete_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/get_connections_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/reject_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/update_connection_name_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getConnectionsUseCaseProvider = Provider<GetConnectionsUseCase>((ref) {
  return GetConnectionsUseCase(ref.watch(connectionRepositoryProvider));
});

final addConnectionUseCaseProvider = Provider<AddConnectionUseCase>((ref) {
  return AddConnectionUseCase(ref.watch(connectionRepositoryProvider));
});

final updateConnectionNameUseCaseProvider =
    Provider<UpdateConnectionNameUseCase>((ref) {
  return UpdateConnectionNameUseCase(ref.watch(connectionRepositoryProvider));
});

final acceptConnectionUseCaseProvider =
    Provider<AcceptConnectionUseCase>((ref) {
  return AcceptConnectionUseCase(ref.watch(connectionRepositoryProvider));
});

final rejectConnectionUseCaseProvider =
    Provider<RejectConnectionUseCase>((ref) {
  return RejectConnectionUseCase(ref.watch(connectionRepositoryProvider));
});

final deleteConnectionUseCaseProvider =
    Provider<DeleteConnectionUseCase>((ref) {
  return DeleteConnectionUseCase(ref.watch(connectionRepositoryProvider));
});
