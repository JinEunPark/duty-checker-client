import 'package:duty_checker/auth/data/model/register_resp_model.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterRespModel', () {
    test('fromJson으로 올바르게 파싱된다', () {
      final json = {'id': 1, 'phone': '01012345678', 'role': 'SUBJECT'};

      final model = RegisterRespModel.fromJson(json);

      expect(model.id, 1);
      expect(model.phone, '01012345678');
      expect(model.role, 'SUBJECT');
    });

    test('null 필드가 있어도 파싱된다', () {
      final json = <String, dynamic>{};

      final model = RegisterRespModel.fromJson(json);

      expect(model.id, isNull);
      expect(model.phone, isNull);
      expect(model.role, isNull);
    });
  });

  group('RegisterRespModel.toDomain', () {
    test('GUARDIAN role이 올바르게 변환된다', () {
      const model = RegisterRespModel(id: 1, phone: '010', role: 'GUARDIAN');

      final user = model.toDomain();

      expect(user.id, 1);
      expect(user.phone, '010');
      expect(user.role, UserRole.guardian);
      expect(user.isGuardian, true);
    });

    test('SUBJECT role이 올바르게 변환된다', () {
      const model = RegisterRespModel(id: 2, phone: '010', role: 'SUBJECT');

      final user = model.toDomain();

      expect(user.role, UserRole.subject);
      expect(user.isSubject, true);
    });

    test('null 필드는 기본값으로 변환된다', () {
      const model = RegisterRespModel();

      final user = model.toDomain();

      expect(user.id, 0);
      expect(user.phone, '');
      expect(user.role, UserRole.subject);
    });
  });
}
