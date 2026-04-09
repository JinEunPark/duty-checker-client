import 'package:duty_checker/check_in/data/model/create_check_in_resp_model.dart';
import 'package:duty_checker/check_in/data/repository/check_in_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreateCheckInRespModel', () {
    final json = {
      'id': 1,
      'checkedAt': '2026-04-09T10:30:00Z',
      'status': 'CHECKED',
    };

    test('fromJson으로 올바르게 파싱된다', () {
      final model = CreateCheckInRespModel.fromJson(json);
      expect(model.id, 1);
      expect(model.checkedAt, '2026-04-09T10:30:00Z');
      expect(model.status, 'CHECKED');
    });

    test('null 필드가 있어도 파싱된다', () {
      final model = CreateCheckInRespModel.fromJson({});
      expect(model.id, isNull);
      expect(model.checkedAt, isNull);
      expect(model.status, isNull);
    });

    group('toDomain', () {
      test('올바르게 변환된다', () {
        final model = CreateCheckInRespModel.fromJson(json);
        final entity = model.toDomain();
        expect(entity.id, 1);
        // 서버 UTC 시각이 로컬로 변환되어야 함 (절대 시각은 동일)
        expect(
          entity.checkedAt.isAtSameMomentAs(DateTime.utc(2026, 4, 9, 10, 30)),
          true,
        );
        expect(entity.checkedAt.isUtc, false);
        expect(entity.status, 'CHECKED');
      });

      test('null 필드는 기본값으로 변환된다', () {
        final model = CreateCheckInRespModel.fromJson({});
        final entity = model.toDomain();
        expect(entity.id, 0);
        expect(entity.status, '');
        expect(entity.checkedAt, isNotNull);
      });
    });
  });
}
