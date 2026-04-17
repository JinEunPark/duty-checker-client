import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:duty_checker/connection/data/model/connection_resp_model.dart';
import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConnectionRespModel', () {
    final json = {
      'id': 1,
      'phone': '01012345678',
      'name': '엄마',
      'status': 'CONNECTED',
      'latestCheckedAt': '2026-04-09T10:30:00Z',
      'isTodayChecked': true,
    };

    test('fromJson으로 올바르게 파싱된다', () {
      final model = ConnectionRespModel.fromJson(json);
      expect(model.id, 1);
      expect(model.phone, '01012345678');
      expect(model.name, '엄마');
      expect(model.status, 'CONNECTED');
      expect(model.latestCheckedAt, '2026-04-09T10:30:00Z');
      expect(model.isTodayChecked, true);
    });

    test('null 필드가 있어도 파싱된다', () {
      final model = ConnectionRespModel.fromJson({});
      expect(model.id, isNull);
      expect(model.phone, isNull);
      expect(model.name, isNull);
      expect(model.status, isNull);
      expect(model.latestCheckedAt, isNull);
      expect(model.isTodayChecked, isNull);
    });

    group('toDomain', () {
      test('CONNECTED status가 올바르게 변환된다', () {
        final model = ConnectionRespModel.fromJson(json);
        final entity = model.toDomain();
        expect(entity.id, 1);
        expect(entity.phone, '01012345678');
        expect(entity.name, '엄마');
        expect(entity.status, ConnectionStatus.connected);
        expect(entity.latestCheckedAt, isNotNull);
        expect(entity.isTodayChecked, true);
      });

      test('PENDING status가 올바르게 변환된다', () {
        final model = ConnectionRespModel.fromJson({
          ...json,
          'status': 'PENDING',
        });
        final entity = model.toDomain();
        expect(entity.status, ConnectionStatus.pending);
      });

      test('null 필드는 기본값으로 변환된다', () {
        final model = ConnectionRespModel.fromJson({});
        final entity = model.toDomain();
        expect(entity.id, 0);
        expect(entity.phone, '');
        expect(entity.name, '');
        expect(entity.status, ConnectionStatus.connected);
        expect(entity.latestCheckedAt, isNull);
        expect(entity.isTodayChecked, false);
        expect(entity.requesterRole, isNull);
      });

      test('requesterRole이 SUBJECT로 올바르게 변환된다', () {
        final model = ConnectionRespModel.fromJson({
          ...json,
          'requesterRole': 'SUBJECT',
        });
        final entity = model.toDomain();
        expect(entity.requesterRole, UserRole.subject);
      });

      test('requesterRole이 GUARDIAN으로 올바르게 변환된다', () {
        final model = ConnectionRespModel.fromJson({
          ...json,
          'requesterRole': 'GUARDIAN',
        });
        final entity = model.toDomain();
        expect(entity.requesterRole, UserRole.guardian);
      });

      test('requesterRole이 null이면 null로 변환된다', () {
        final model = ConnectionRespModel.fromJson(json);
        final entity = model.toDomain();
        expect(entity.requesterRole, isNull);
      });
    });
  });
}
