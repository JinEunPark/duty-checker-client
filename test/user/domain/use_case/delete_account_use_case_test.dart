import 'package:duty_checker/user/domain/use_case/delete_account_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_user.dart';

void main() {
  late MockUserRepository mockRepository;
  late DeleteAccountUseCase useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = DeleteAccountUseCase(mockRepository);
  });

  group('DeleteAccountUseCase', () {
    test('성공 시 Repository.deleteAccount()를 호출한다', () async {
      when(() => mockRepository.deleteAccount())
          .thenAnswer((_) async {});

      await useCase();

      verify(() => mockRepository.deleteAccount()).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.deleteAccount())
          .thenThrow(Exception('탈퇴 실패'));

      expect(
        () => useCase(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
