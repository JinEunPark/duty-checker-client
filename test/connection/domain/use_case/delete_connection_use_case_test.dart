import 'package:duty_checker/connection/domain/use_case/delete_connection_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockConnectionRepository mockRepository;
  late DeleteConnectionUseCase useCase;

  setUp(() {
    mockRepository = MockConnectionRepository();
    useCase = DeleteConnectionUseCase(mockRepository);
  });

  group('DeleteConnectionUseCase', () {
    test('성공 시 Repository.deleteConnection()을 호출한다', () async {
      when(() => mockRepository.deleteConnection(id: any(named: 'id')))
          .thenAnswer((_) async {});

      await useCase(id: 1);

      verify(() => mockRepository.deleteConnection(id: 1)).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.deleteConnection(id: any(named: 'id')))
          .thenThrow(Exception('존재하지 않는 연결'));

      expect(
        () => useCase(id: 1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
