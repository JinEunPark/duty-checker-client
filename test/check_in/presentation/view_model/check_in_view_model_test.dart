import 'package:duty_checker/check_in/domain/use_case/check_in_use_case_providers.dart';
import 'package:duty_checker/check_in/presentation/view_model/check_in_view_model.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_check_in.dart';

void main() {
  late MockCreateCheckInUseCase mockCreateCheckIn;
  late MockGetLatestCheckInUseCase mockGetLatestCheckIn;

  setUp(() {
    mockCreateCheckIn = MockCreateCheckInUseCase();
    mockGetLatestCheckIn = MockGetLatestCheckInUseCase();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        createCheckInUseCaseProvider.overrideWithValue(mockCreateCheckIn),
        getLatestCheckInUseCaseProvider
            .overrideWithValue(mockGetLatestCheckIn),
      ],
    );
  }

  group('CheckInViewModel', () {
    test('초기 빌드 시 최신 체크인 정보를 로드한다', () {
      when(() => mockGetLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckIn);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        container.read(checkInViewModelProvider.notifier);
        async.flushMicrotasks();

        final state = container.read(checkInViewModelProvider);
        expect(state.isLoading, false);
        expect(state.todayChecked, false);
        expect(state.latestCheckedAt, isNull);
        expect(state.error, isNull);
      });
    });

    test('오늘 체크인한 기록이 있으면 todayChecked가 true이다', () {
      when(() => mockGetLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckInWithData);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        container.read(checkInViewModelProvider.notifier);
        async.flushMicrotasks();

        final state = container.read(checkInViewModelProvider);
        expect(state.todayChecked, true);
        expect(state.latestCheckedAt, isNotNull);
      });
    });

    test('checkIn 성공 시 todayChecked가 true가 된다', () {
      when(() => mockGetLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckIn);
      when(() => mockCreateCheckIn())
          .thenAnswer((_) async => testCheckIn);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(checkInViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.checkIn();
        async.flushMicrotasks();

        final state = container.read(checkInViewModelProvider);
        expect(state.isLoading, false);
        expect(state.todayChecked, true);
        expect(state.latestCheckedAt, testCheckIn.checkedAt);
        expect(state.error, isNull);
      });
    });

    test('checkIn 실패 시 error가 설정된다', () {
      when(() => mockGetLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckIn);
      when(() => mockCreateCheckIn())
          .thenThrow(Exception('이미 체크인함'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(checkInViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.checkIn();
        async.flushMicrotasks();

        final state = container.read(checkInViewModelProvider);
        expect(state.isLoading, false);
        expect(state.error, isNotNull);
      });
    });

    test('이미 체크인한 경우 중복 호출하지 않는다', () {
      when(() => mockGetLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckIn);
      when(() => mockCreateCheckIn())
          .thenAnswer((_) async => testCheckIn);

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        final notifier = container.read(checkInViewModelProvider.notifier);
        async.flushMicrotasks();

        notifier.checkIn();
        async.flushMicrotasks();
        notifier.checkIn();
        async.flushMicrotasks();

        verify(() => mockCreateCheckIn()).called(1);
      });
    });

    test('초기 로드 실패 시 error가 설정된다', () {
      when(() => mockGetLatestCheckIn())
          .thenAnswer((_) async => throw Exception('서버 에러'));

      fakeAsync((async) {
        final container = createContainer();
        addTearDown(container.dispose);

        container.read(checkInViewModelProvider.notifier);
        async.flushMicrotasks();

        final state = container.read(checkInViewModelProvider);
        expect(state.error, isNotNull);
      });
    });
  });
}
