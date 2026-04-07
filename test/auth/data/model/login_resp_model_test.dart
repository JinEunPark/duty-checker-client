import 'package:duty_checker/auth/data/model/login_resp_model.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginRespModel', () {
    test('fromJson으로 올바르게 파싱된다', () {
      final json = {
        'accessToken': 'access123',
        'refreshToken': 'refresh456',
        'user': {'id': 1, 'phone': '01012345678', 'role': 'GUARDIAN'},
      };

      final model = LoginRespModel.fromJson(json);

      expect(model.accessToken, 'access123');
      expect(model.refreshToken, 'refresh456');
      expect(model.user?.id, 1);
      expect(model.user?.phone, '01012345678');
      expect(model.user?.role, 'GUARDIAN');
    });

    test('null 필드가 있어도 파싱된다', () {
      final json = <String, dynamic>{};

      final model = LoginRespModel.fromJson(json);

      expect(model.accessToken, isNull);
      expect(model.refreshToken, isNull);
      expect(model.user, isNull);
    });
  });

  group('LoginRespModel.toDomain', () {
    test('GUARDIAN role이 올바르게 변환된다', () {
      const model = LoginRespModel(
        accessToken: 'access',
        refreshToken: 'refresh',
        user: UserInfoModel(id: 1, phone: '010', role: 'GUARDIAN'),
      );

      final result = model.toDomain();

      expect(result.token.accessToken, 'access');
      expect(result.token.refreshToken, 'refresh');
      expect(result.user.id, 1);
      expect(result.user.role, UserRole.guardian);
    });

    test('SUBJECT role이 올바르게 변환된다', () {
      const model = LoginRespModel(
        accessToken: 'a',
        refreshToken: 'r',
        user: UserInfoModel(id: 2, phone: '010', role: 'SUBJECT'),
      );

      final result = model.toDomain();

      expect(result.user.role, UserRole.subject);
    });

    test('알 수 없는 role은 subject로 기본 매핑된다', () {
      const model = LoginRespModel(
        accessToken: 'a',
        refreshToken: 'r',
        user: UserInfoModel(id: 3, phone: '010', role: 'UNKNOWN'),
      );

      final result = model.toDomain();

      expect(result.user.role, UserRole.subject);
    });

    test('null role은 subject로 기본 매핑된다', () {
      const model = LoginRespModel(
        accessToken: 'a',
        refreshToken: 'r',
        user: UserInfoModel(id: 4, phone: '010', role: null),
      );

      final result = model.toDomain();

      expect(result.user.role, UserRole.subject);
    });
  });
}
