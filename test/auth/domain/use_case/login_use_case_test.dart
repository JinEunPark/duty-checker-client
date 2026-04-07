import 'package:duty_checker/auth/domain/use_case/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    test('성공 시 LoginResult를 반환한다', () async {
      when(() => mockRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testLoginResult);

      final result = await useCase(
        phone: '01012345678',
        password: 'password123',
      );

      expect(result, testLoginResult);
      expect(result.user.phone, '01012345678');
      expect(result.token.accessToken, 'access123');
      verify(() => mockRepository.login(
            phone: '01012345678',
            password: 'password123',
          )).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenThrow(Exception('인증 실패'));

      expect(
        () => useCase(phone: '010', password: 'wrong'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
