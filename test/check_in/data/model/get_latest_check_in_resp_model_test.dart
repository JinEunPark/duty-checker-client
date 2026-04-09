import 'package:duty_checker/check_in/data/model/get_latest_check_in_resp_model.dart';
import 'package:duty_checker/check_in/data/repository/check_in_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetLatestCheckInRespModel', () {
    final json = {
      'latestCheckedAt': '2026-04-09T10:30:00Z',
      'todayChecked': true,
    };

    test('fromJson으로 올바르게 파싱된다', () {
      final model = GetLatestCheckInRespModel.fromJson(json);
      expect(model.latestCheckedAt, '2026-04-09T10:30:00Z');
      expect(model.todayChecked, true);
    });

    test('null 필드가 있어도 파싱된다', () {
      final model = GetLatestCheckInRespModel.fromJson({});
      expect(model.latestCheckedAt, isNull);
      expect(model.todayChecked, isNull);
    });

    group('toDomain', () {
      test('올바르게 변환된다', () {
        final model = GetLatestCheckInRespModel.fromJson(json);
        final entity = model.toDomain();
        // 서버 UTC 시각이 로컬로 변환되어야 함 (절대 시각은 동일)
        expect(
          entity.latestCheckedAt!.isAtSameMomentAs(DateTime.utc(2026, 4, 9, 10, 30)),
          true,
        );
        expect(entity.latestCheckedAt!.isUtc, false);
        expect(entity.todayChecked, true);
      });

      test('체크인 기록이 없으면 null과 false로 변환된다', () {
        final model = GetLatestCheckInRespModel.fromJson({});
        final entity = model.toDomain();
        expect(entity.latestCheckedAt, isNull);
        expect(entity.todayChecked, false);
      });
    });
  });
}
