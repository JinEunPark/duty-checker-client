import 'package:duty_checker/connection/domain/use_case/get_connections_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockConnectionRepository mockRepository;
  late GetConnectionsUseCase useCase;

  setUp(() {
    mockRepository = MockConnectionRepository();
    useCase = GetConnectionsUseCase(mockRepository);
  });

  group('GetConnectionsUseCase', () {
    test('성공 시 ConnectionList를 반환한다', () async {
      when(() => mockRepository.getConnections())
          .thenAnswer((_) async => testConnectionList);

      final result = await useCase();
      expect(result.connections, hasLength(2));
      verify(() => mockRepository.getConnections()).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.getConnections())
          .thenThrow(Exception('서버 에러'));

      expect(() => useCase(), throwsA(isA<Exception>()));
    });
  });
}
