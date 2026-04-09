import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/use_case/update_connection_name_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_connection.dart';

void main() {
  late MockConnectionRepository mockRepository;
  late UpdateConnectionNameUseCase useCase;

  setUp(() {
    mockRepository = MockConnectionRepository();
    useCase = UpdateConnectionNameUseCase(mockRepository);
  });

  group('UpdateConnectionNameUseCase', () {
    test('성공 시 업데이트된 Connection을 반환한다', () async {
      const updated = Connection(
        id: 1,
        phone: '01012345678',
        name: '어머니',
        status: ConnectionStatus.connected,
        latestCheckedAt: null,
        isTodayChecked: false,
      );
      when(() => mockRepository.updateConnectionName(
            id: any(named: 'id'),
            name: any(named: 'name'),
          )).thenAnswer((_) async => updated);

      final result = await useCase(id: 1, name: '어머니');
      expect(result.name, '어머니');
      verify(() => mockRepository.updateConnectionName(
            id: 1,
            name: '어머니',
          )).called(1);
    });

    test('Repository 예외를 그대로 전파한다', () async {
      when(() => mockRepository.updateConnectionName(
            id: any(named: 'id'),
            name: any(named: 'name'),
          )).thenThrow(Exception('연결 없음'));

      expect(
        () => useCase(id: 999, name: '테스트'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
