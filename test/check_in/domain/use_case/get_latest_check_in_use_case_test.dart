import 'package:duty_checker/check_in/domain/use_case/get_latest_check_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_check_in.dart';

void main() {
  late MockCheckInRepository mockRepository;
  late GetLatestCheckInUseCase useCase;

  setUp(() {
    mockRepository = MockCheckInRepository();
    useCase = GetLatestCheckInUseCase(mockRepository);
  });

  group('GetLatestCheckInUseCase', () {
    test('성공 시 LatestCheckIn을 반환한다', () async {
      when(() => mockRepository.getLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckInWithData);

      final result = await useCase();
      expect(result.todayChecked, true);
      expect(result.latestCheckedAt, isNotNull);
      verify(() => mockRepository.getLatestCheckIn()).called(1);
    });

    test('체크인 기록이 없어도 반환한다', () async {
      when(() => mockRepository.getLatestCheckIn())
          .thenAnswer((_) async => testLatestCheckIn);

      final result = await useCase();
      expect(result.todayChecked, false);
      expect(result.latestCheckedAt, isNull);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.getLatestCheckIn())
          .thenThrow(Exception('서버 에러'));

      expect(() => useCase(), throwsA(isA<Exception>()));
    });
  });
}
