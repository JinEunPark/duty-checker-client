import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences 인스턴스를 제공하는 Provider
///
/// main.dart에서 앱 시작 시 초기화된 SharedPreferences를
/// overrideWithValue()로 주입합니다.
///
/// 사용 예시:
/// ```dart
/// final prefs = ref.watch(sharedPreferencesProvider);
/// prefs.getString('key');
/// ```
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('main.dart에서 override 필요'),
);
