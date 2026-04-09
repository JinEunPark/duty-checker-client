import 'package:duty_checker/connection/data/model/get_connections_resp_model.dart';
import 'package:duty_checker/connection/data/repository/connection_repository_impl.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetConnectionsRespModel', () {
    final json = {
      'role': 'SUBJECT',
      'connections': [
        {
          'id': 1,
          'phone': '01012345678',
          'name': '엄마',
          'status': 'CONNECTED',
          'latestCheckedAt': '2026-04-09T10:30:00Z',
          'isTodayChecked': true,
        },
        {
          'id': 2,
          'phone': '01087654321',
          'name': '아빠',
          'status': 'PENDING',
          'isTodayChecked': false,
        },
      ],
    };

    test('fromJson으로 올바르게 파싱된다', () {
      final model = GetConnectionsRespModel.fromJson(json);
      expect(model.role, 'SUBJECT');
      expect(model.connections, hasLength(2));
      expect(model.connections![0].name, '엄마');
      expect(model.connections![1].status, 'PENDING');
    });

    test('빈 connections도 파싱된다', () {
      final model = GetConnectionsRespModel.fromJson({
        'role': 'GUARDIAN',
        'connections': [],
      });
      expect(model.role, 'GUARDIAN');
      expect(model.connections, isEmpty);
    });

    group('toDomain', () {
      test('SUBJECT role과 connections가 올바르게 변환된다', () {
        final model = GetConnectionsRespModel.fromJson(json);
        final entity = model.toDomain();
        expect(entity.role, UserRole.subject);
        expect(entity.connections, hasLength(2));
        expect(entity.connections[0].status, ConnectionStatus.connected);
        expect(entity.connections[1].status, ConnectionStatus.pending);
      });

      test('GUARDIAN role이 올바르게 변환된다', () {
        final model = GetConnectionsRespModel.fromJson({
          'role': 'GUARDIAN',
          'connections': [],
        });
        final entity = model.toDomain();
        expect(entity.role, UserRole.guardian);
        expect(entity.connections, isEmpty);
      });

      test('null connections는 빈 리스트로 변환된다', () {
        final model = GetConnectionsRespModel.fromJson({'role': 'SUBJECT'});
        final entity = model.toDomain();
        expect(entity.connections, isEmpty);
      });
    });
  });
}
