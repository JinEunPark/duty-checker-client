import 'package:duty_checker/connection/domain/use_case/reject_connection_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockConnectionRepository mockRepository;
  late RejectConnectionUseCase useCase;

  setUp(() {
    mockRepository = MockConnectionRepository();
    useCase = RejectConnectionUseCase(mockRepository);
  });

  group('RejectConnectionUseCase', () {
    test('성공 시 Repository.rejectConnection()을 호출한다', () async {
      when(() => mockRepository.rejectConnection(id: any(named: 'id')))
          .thenAnswer((_) async {});

      await useCase(id: 1);

      verify(() => mockRepository.rejectConnection(id: 1)).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.rejectConnection(id: any(named: 'id')))
          .thenThrow(Exception('이미 처리됨'));

      expect(
        () => useCase(id: 1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
