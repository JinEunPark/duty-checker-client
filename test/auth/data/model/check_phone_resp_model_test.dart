import 'package:duty_checker/auth/data/model/check_phone_resp_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckPhoneRespModel', () {
    test('fromJson으로 올바르게 파싱된다', () {
      final model = CheckPhoneRespModel.fromJson({'exists': true});
      expect(model.exists, isTrue);
    });

    test('exists가 false인 경우', () {
      final model = CheckPhoneRespModel.fromJson({'exists': false});
      expect(model.exists, isFalse);
    });

    test('빈 JSON이면 기본값 false', () {
      final model = CheckPhoneRespModel.fromJson({});
      expect(model.exists, isFalse);
    });
  });
}
