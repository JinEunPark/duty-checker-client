import 'package:duty_checker/core/fcm/update_device_token_req_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UpdateDeviceTokenReqModel', () {
    test('fromJson 파싱', () {
      final json = {'fcmToken': 'test_token_123'};
      final model = UpdateDeviceTokenReqModel.fromJson(json);

      expect(model.fcmToken, 'test_token_123');
    });

    test('toJson 변환', () {
      const model = UpdateDeviceTokenReqModel(fcmToken: 'test_token_456');
      final json = model.toJson();

      expect(json['fcmToken'], 'test_token_456');
    });

    test('동등성 비교', () {
      const a = UpdateDeviceTokenReqModel(fcmToken: 'token');
      const b = UpdateDeviceTokenReqModel(fcmToken: 'token');

      expect(a, b);
    });
  });
}
