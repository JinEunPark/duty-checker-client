import 'package:duty_checker/core/date_time_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseServerDateTime', () {
    test('null이면 null을 반환한다', () {
      expect(parseServerDateTime(null), isNull);
    });

    test('빈 문자열이면 null을 반환한다', () {
      expect(parseServerDateTime(''), isNull);
    });

    test('Z가 포함된 ISO 문자열은 UTC로 파싱 후 로컬로 변환한다', () {
      final result = parseServerDateTime('2026-04-09T10:30:00Z');
      expect(result, isNotNull);
      expect(result!.isUtc, false);
      // 동일한 절대 시각을 표현해야 함
      expect(
        result.isAtSameMomentAs(DateTime.utc(2026, 4, 9, 10, 30)),
        true,
      );
    });

    test('timezone 표기가 없는 문자열은 UTC로 간주하고 로컬로 변환한다', () {
      final result = parseServerDateTime('2026-04-09T10:30:00');
      expect(result, isNotNull);
      expect(result!.isUtc, false);
      // Z가 없어도 UTC로 간주되어 동일한 절대 시각이어야 함
      expect(
        result.isAtSameMomentAs(DateTime.utc(2026, 4, 9, 10, 30)),
        true,
      );
    });

    test('+09:00 같은 timezone offset이 있으면 그대로 사용한다', () {
      final result = parseServerDateTime('2026-04-09T19:30:00+09:00');
      expect(result, isNotNull);
      expect(result!.isUtc, false);
      // KST 19:30은 UTC 10:30과 동일
      expect(
        result.isAtSameMomentAs(DateTime.utc(2026, 4, 9, 10, 30)),
        true,
      );
    });

    test('마이크로초 포함 ISO 문자열도 처리한다', () {
      final result = parseServerDateTime('2026-04-09T10:30:00.123456Z');
      expect(result, isNotNull);
      expect(result!.isUtc, false);
    });

    test('잘못된 형식은 null을 반환한다', () {
      expect(parseServerDateTime('not-a-date'), isNull);
    });
  });
}
