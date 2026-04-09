import 'package:duty_checker/check_in/domain/use_case/create_check_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_check_in.dart';

void main() {
  late MockCheckInRepository mockRepository;
  late CreateCheckInUseCase useCase;

  setUp(() {
    mockRepository = MockCheckInRepository();
    useCase = CreateCheckInUseCase(mockRepository);
  });

  group('CreateCheckInUseCase', () {
    test('성공 시 CheckIn을 반환한다', () async {
      when(() => mockRepository.createCheckIn())
          .thenAnswer((_) async => testCheckIn);

      final result = await useCase();
      expect(result.id, 1);
      expect(result.status, 'CHECKED');
      verify(() => mockRepository.createCheckIn()).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.createCheckIn())
          .thenThrow(Exception('이미 체크인함'));

      expect(() => useCase(), throwsA(isA<Exception>()));
    });
  });
}
