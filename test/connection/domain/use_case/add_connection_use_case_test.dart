import 'package:duty_checker/connection/domain/use_case/add_connection_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockConnectionRepository mockRepository;
  late AddConnectionUseCase useCase;

  setUp(() {
    mockRepository = MockConnectionRepository();
    useCase = AddConnectionUseCase(mockRepository);
  });

  group('AddConnectionUseCase', () {
    test('성공 시 Connection을 반환한다', () async {
      when(() => mockRepository.addConnection(
            targetPhone: any(named: 'targetPhone'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => testPendingConnection);

      final result = await useCase(
        targetPhone: '01087654321',
        name: '아빠',
      );
      expect(result.phone, '01087654321');
      verify(() => mockRepository.addConnection(
            targetPhone: '01087654321',
            name: '아빠',
          )).called(1);
    });

    test('name 없이 호출할 수 있다', () async {
      when(() => mockRepository.addConnection(
            targetPhone: any(named: 'targetPhone'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => testPendingConnection);

      await useCase(targetPhone: '01087654321');
      verify(() => mockRepository.addConnection(
            targetPhone: '01087654321',
          )).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.addConnection(
            targetPhone: any(named: 'targetPhone'),
            name: any(named: 'name'),
          )).thenThrow(Exception('이미 연결됨'));

      expect(
        () => useCase(targetPhone: '01087654321'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
