import 'package:duty_checker/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeModeNotifier', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('초기값 false로 생성된다', () {
      final notifier = ThemeModeNotifier(false, prefs);
      expect(notifier.state, false);
    });

    test('초기값 true로 생성된다', () {
      final notifier = ThemeModeNotifier(true, prefs);
      expect(notifier.state, true);
    });

    test('toggle(true) 시 state가 true가 된다', () {
      final notifier = ThemeModeNotifier(false, prefs);
      notifier.toggle(true);
      expect(notifier.state, true);
    });

    test('toggle(false) 시 state가 false가 된다', () {
      final notifier = ThemeModeNotifier(true, prefs);
      notifier.toggle(false);
      expect(notifier.state, false);
    });

    test('toggle 시 SharedPreferences에 저장된다', () {
      final notifier = ThemeModeNotifier(false, prefs);
      notifier.toggle(true);
      expect(prefs.getBool('is_dark_mode'), true);
    });

    test('SharedPreferences에서 저장된 값을 읽어 초기화한다', () async {
      SharedPreferences.setMockInitialValues({'is_dark_mode': true});
      final savedPrefs = await SharedPreferences.getInstance();

      final isDark = savedPrefs.getBool('is_dark_mode') ?? false;
      final notifier = ThemeModeNotifier(isDark, savedPrefs);
      expect(notifier.state, true);
    });
  });
}
