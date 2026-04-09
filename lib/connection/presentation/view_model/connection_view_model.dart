import 'package:duty_checker/connection/domain/use_case/connection_use_case_providers.dart';
import 'package:duty_checker/connection/presentation/state/connection_state.dart';
import 'package:duty_checker/core/error/app_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_view_model.g.dart';

@riverpod
class ConnectionViewModel extends _$ConnectionViewModel {
  @override
  ConnectionState build() {
    _loadConnections();
    return const ConnectionState(isLoading: true);
  }

  Future<void> _loadConnections() async {
    try {
      final useCase = ref.read(getConnectionsUseCaseProvider);
      final result = await useCase();
      state = ConnectionState(connections: result.connections);
    } catch (e) {
      final appError = AppError.from(e);
      state = ConnectionState(error: appError.message);
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadConnections();
  }

  Future<void> addConnection({
    required String guardianPhone,
    String? name,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(addConnectionUseCaseProvider);
      final newConnection =
          await useCase(guardianPhone: guardianPhone, name: name);
      state = ConnectionState(
        connections: [...state.connections, newConnection],
      );
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(isLoading: false, error: appError.message);
    }
  }

  Future<void> updateConnectionName({
    required int id,
    required String name,
  }) async {
    state = state.copyWith(error: null);
    try {
      final useCase = ref.read(updateConnectionNameUseCaseProvider);
      final updated = await useCase(id: id, name: name);
      final newList = state.connections.map((c) {
        return c.id == updated.id ? updated : c;
      }).toList();
      state = state.copyWith(connections: newList);
    } catch (e) {
      final appError = AppError.from(e);
      state = state.copyWith(error: appError.message);
    }
  }
}
