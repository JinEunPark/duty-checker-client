import 'package:duty_checker/auth/domain/use_case/send_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockAuthRepository mockRepository;
  late SendCodeUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SendCodeUseCase(mockRepository);
  });

  group('SendCodeUseCase', () {
    test('성공 시 만료 시각을 반환한다', () async {
      final expiredAt = DateTime(2026, 4, 7, 12, 0);
      when(() => mockRepository.sendCode(
            phone: any(named: 'phone'),
          )).thenAnswer((_) async => expiredAt);

      final result = await useCase(phone: '01012345678');

      expect(result, expiredAt);
      verify(() => mockRepository.sendCode(phone: '01012345678')).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.sendCode(
            phone: any(named: 'phone'),
          )).thenThrow(Exception('발송 실패'));

      expect(
        () => useCase(phone: '010'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
