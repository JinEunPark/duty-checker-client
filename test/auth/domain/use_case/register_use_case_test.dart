import 'package:duty_checker/auth/domain/use_case/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockAuthRepository mockRepository;
  late RegisterUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockRepository);
  });

  group('RegisterUseCase', () {
    test('성공 시 User를 반환한다', () async {
      when(() => mockRepository.register(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenAnswer((_) async => testUser);

      final result = await useCase(
        phone: '01012345678',
        password: 'password123',
        role: 'SUBJECT',
      );

      expect(result, testUser);
      verify(() => mockRepository.register(
            phone: '01012345678',
            password: 'password123',
            role: 'SUBJECT',
          )).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.register(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            role: any(named: 'role'),
          )).thenThrow(Exception('이미 가입된 번호'));

      expect(
        () => useCase(phone: '010', password: 'pw', role: 'SUBJECT'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
