import 'package:duty_checker/auth/domain/use_case/check_phone_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockAuthRepository mockRepository;
  late CheckPhoneUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = CheckPhoneUseCase(mockRepository);
  });

  group('CheckPhoneUseCase', () {
    test('가입된 번호이면 true를 반환한다', () async {
      when(() => mockRepository.checkPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => true);

      final result = await useCase(phone: '01012345678');

      expect(result, isTrue);
      verify(() => mockRepository.checkPhone(phone: '01012345678')).called(1);
    });

    test('미가입 번호이면 false를 반환한다', () async {
      when(() => mockRepository.checkPhone(phone: any(named: 'phone')))
          .thenAnswer((_) async => false);

      final result = await useCase(phone: '01099998888');

      expect(result, isFalse);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.checkPhone(phone: any(named: 'phone')))
          .thenThrow(Exception('네트워크 오류'));

      expect(
        () => useCase(phone: '01012345678'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
