import 'package:duty_checker/connection/domain/use_case/accept_connection_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockConnectionRepository mockRepository;
  late AcceptConnectionUseCase useCase;

  setUp(() {
    mockRepository = MockConnectionRepository();
    useCase = AcceptConnectionUseCase(mockRepository);
  });

  group('AcceptConnectionUseCase', () {
    test('성공 시 Repository.acceptConnection()을 호출한다', () async {
      when(() => mockRepository.acceptConnection(id: any(named: 'id')))
          .thenAnswer((_) async {});

      await useCase(id: 1);

      verify(() => mockRepository.acceptConnection(id: 1)).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.acceptConnection(id: any(named: 'id')))
          .thenThrow(Exception('403 Forbidden'));

      expect(
        () => useCase(id: 1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
