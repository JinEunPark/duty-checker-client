import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/use_case/connection_use_case_providers.dart';
import 'package:duty_checker/connection/presentation/view_model/connection_view_model.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockGetConnectionsUseCase mockGetConnections;
  late MockAddConnectionUseCase mockAddConnection;
  late MockUpdateConnectionNameUseCase mockUpdateName;

  setUp(() {
    mockGetConnections = MockGetConnectionsUseCase();
    mockAddConnection = MockAddConnectionUseCase();
    mockUpdateName = MockUpdateConnectionNameUseCase();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        getConnectionsUseCaseProvider.overrideWithValue(mockGetConnections),
        addConnectionUseCaseProvider.overrideWithValue(mockAddConnection),
        updateConnectionNameUseCaseProvider.overrideWithValue(mockUpdateName),
      ],
    );
  }

  group('ConnectionViewModel', () {
    test('초기 빌드 시 connections를 로드한다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.isLoading, false);
        expect(state.connections, hasLength(2));
        expect(state.error, isNull);
      });
    });

    test('로드 실패 시 error가 설정된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => throw Exception('서버 에러'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.isLoading, false);
        expect(state.connections, isEmpty);
        expect(state.error, isNotNull);
      });
    });

    test('addConnection 성공 시 리스트에 추가된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockAddConnection(
            guardianPhone: any(named: 'guardianPhone'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => testPendingConnection);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.addConnection(guardianPhone: '01087654321');
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.isLoading, false);
        expect(state.connections, hasLength(3));
        expect(state.error, isNull);
      });
    });

    test('addConnection 실패 시 error가 설정된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockAddConnection(
            guardianPhone: any(named: 'guardianPhone'),
            name: any(named: 'name'),
          )).thenThrow(Exception('이미 연결됨'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.addConnection(guardianPhone: '01087654321');
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.isLoading, false);
        expect(state.error, isNotNull);
      });
    });

    test('updateConnectionName 성공 시 해당 항목이 업데이트된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      const updated = Connection(
        id: 1,
        phone: '01012345678',
        name: '어머니',
        status: ConnectionStatus.connected,
        latestCheckedAt: null,
        isTodayChecked: false,
      );
      when(() => mockUpdateName(
            id: any(named: 'id'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => updated);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.updateConnectionName(id: 1, name: '어머니');
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        final conn = state.connections.firstWhere((c) => c.id == 1);
        expect(conn.name, '어머니');
        expect(state.error, isNull);
      });
    });

    test('updateConnectionName 실패 시 error가 설정된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockUpdateName(
            id: any(named: 'id'),
            name: any(named: 'name'),
          )).thenThrow(Exception('연결 없음'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.updateConnectionName(id: 999, name: '테스트');
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.error, isNotNull);
      });
    });
  });
}
