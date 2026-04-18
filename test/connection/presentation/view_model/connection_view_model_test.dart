import 'package:duty_checker/auth/domain/entity/user.dart';
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
  late MockAcceptConnectionUseCase mockAcceptConnection;
  late MockRejectConnectionUseCase mockRejectConnection;
  late MockDeleteConnectionUseCase mockDeleteConnection;

  setUp(() {
    mockGetConnections = MockGetConnectionsUseCase();
    mockAddConnection = MockAddConnectionUseCase();
    mockUpdateName = MockUpdateConnectionNameUseCase();
    mockAcceptConnection = MockAcceptConnectionUseCase();
    mockRejectConnection = MockRejectConnectionUseCase();
    mockDeleteConnection = MockDeleteConnectionUseCase();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        getConnectionsUseCaseProvider.overrideWithValue(mockGetConnections),
        addConnectionUseCaseProvider.overrideWithValue(mockAddConnection),
        updateConnectionNameUseCaseProvider.overrideWithValue(mockUpdateName),
        acceptConnectionUseCaseProvider.overrideWithValue(mockAcceptConnection),
        rejectConnectionUseCaseProvider.overrideWithValue(mockRejectConnection),
        deleteConnectionUseCaseProvider.overrideWithValue(mockDeleteConnection),
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

    test('addConnection 성공 시 목록을 새로고침한다', () {
      final newConnection = const Connection(
        id: 3,
        phone: '01099998888',
        name: '동생',
        status: ConnectionStatus.pending,
        latestCheckedAt: null,
        isTodayChecked: false,
      );
      final updatedList = ConnectionList(
        role: UserRole.subject,
        connections: [...testConnectionList.connections, newConnection],
      );

      var callCount = 0;
      when(() => mockGetConnections()).thenAnswer((_) async {
        callCount++;
        return callCount <= 1 ? testConnectionList : updatedList;
      });
      when(() => mockAddConnection(
            targetPhone: any(named: 'targetPhone'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => newConnection);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.addConnection(targetPhone: '01099998888');
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.isLoading, false);
        expect(state.connections, hasLength(3));
        expect(state.error, isNull);
        verify(() => mockGetConnections()).called(2);
      });
    });

    test('addConnection 실패 시 error가 설정된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockAddConnection(
            targetPhone: any(named: 'targetPhone'),
            name: any(named: 'name'),
          )).thenThrow(Exception('이미 연결됨'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.addConnection(targetPhone: '01087654321');
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

    test('acceptConnection 성공 시 목록을 새로고침한다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockAcceptConnection(id: any(named: 'id')))
          .thenAnswer((_) async {});

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.acceptConnection(id: 2);
        async.flushMicrotasks();

        verify(() => mockAcceptConnection(id: 2)).called(1);
        // refresh 호출로 getConnections가 2번 호출됨 (초기 + refresh)
        verify(() => mockGetConnections()).called(2);
      });
    });

    test('acceptConnection 실패 시 error가 설정된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockAcceptConnection(id: any(named: 'id')))
          .thenThrow(Exception('403 Forbidden'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.acceptConnection(id: 1);
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.error, isNotNull);
      });
    });

    test('rejectConnection 성공 시 리스트에서 제거된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockRejectConnection(id: any(named: 'id')))
          .thenAnswer((_) async {});

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.rejectConnection(id: 2);
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.connections, hasLength(1));
        expect(state.connections.any((c) => c.id == 2), isFalse);
      });
    });

    test('deleteConnection 성공 시 리스트에서 제거된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockDeleteConnection(id: any(named: 'id')))
          .thenAnswer((_) async {});

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.deleteConnection(id: 1);
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.connections, hasLength(1));
        expect(state.connections.any((c) => c.id == 1), isFalse);
      });
    });

    test('deleteConnection 실패 시 error가 설정된다', () {
      when(() => mockGetConnections())
          .thenAnswer((_) async => testConnectionList);
      when(() => mockDeleteConnection(id: any(named: 'id')))
          .thenThrow(Exception('존재하지 않는 연결'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(connectionViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.deleteConnection(id: 999);
        async.flushMicrotasks();

        final state = container.read(connectionViewModelProvider);
        expect(state.error, isNotNull);
      });
    });
  });
}
