import 'package:duty_checker/auth/domain/use_case/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockAuthRepository mockRepository;
  late ResetPasswordUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = ResetPasswordUseCase(mockRepository);
  });

  group('ResetPasswordUseCase', () {
    test('성공 시 Repository.resetPassword를 올바른 인자로 호출한다', () async {
      when(() => mockRepository.resetPassword(
            phone: any(named: 'phone'),
            newPassword: any(named: 'newPassword'),
          )).thenAnswer((_) async {});

      await useCase(phone: '01012345678', newPassword: 'newPw123');

      verify(() => mockRepository.resetPassword(
            phone: '01012345678',
            newPassword: 'newPw123',
          )).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.resetPassword(
            phone: any(named: 'phone'),
            newPassword: any(named: 'newPassword'),
          )).thenThrow(Exception('네트워크 오류'));

      expect(
        () => useCase(phone: '01012345678', newPassword: 'newPw123'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
