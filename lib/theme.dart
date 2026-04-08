import 'package:duty_checker/core/shared_preferences_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────
// 다크모드 상태 Provider (SharedPreferences 연동)
// ─────────────────────────────────────────────
const _darkModeKey = 'is_dark_mode';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeNotifier(prefs.getBool(_darkModeKey) ?? false, prefs);
});

class ThemeModeNotifier extends StateNotifier<bool> {
  ThemeModeNotifier(super.isDark, this._prefs);

  final SharedPreferences _prefs;

  void toggle(bool value) {
    state = value;
    _prefs.setBool(_darkModeKey, value);
  }
}

// ─────────────────────────────────────────────
// 앱 색상 스킴 (라이트 / 다크)
// ─────────────────────────────────────────────
class AppColorScheme {
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;

  final Color background;
  final Color surface;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;

  final Color border;
  final Color divider;

  final Color success;
  final Color error;
  final Color warning;

  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;

  const AppColorScheme({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.border,
    required this.divider,
    required this.success,
    required this.error,
    required this.warning,
    required this.gray100,
    required this.gray200,
    required this.gray300,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray800,
    required this.gray900,
  });

  static const light = AppColorScheme(
    primary: Color(0xFF3182F6),
    primaryLight: Color(0xFFEBF3FF),
    primaryDark: Color(0xFF1B64DA),
    background: Color(0xFFF2F4F6),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF191F28),
    textSecondary: Color(0xFF6B7684),
    textTertiary: Color(0xFF8B95A1),
    textDisabled: Color(0xFFB0B8C1),
    border: Color(0xFFE5E8EB),
    divider: Color(0xFFF2F4F6),
    success: Color(0xFF00C471),
    error: Color(0xFFF04452),
    warning: Color(0xFFFF9500),
    gray100: Color(0xFFF2F4F6),
    gray200: Color(0xFFE5E8EB),
    gray300: Color(0xFFD1D6DB),
    gray400: Color(0xFFB0B8C1),
    gray500: Color(0xFF8B95A1),
    gray600: Color(0xFF6B7684),
    gray700: Color(0xFF4E5968),
    gray800: Color(0xFF333D4B),
    gray900: Color(0xFF191F28),
  );

  static const dark = AppColorScheme(
    primary: Color(0xFF4E96F7),
    primaryLight: Color(0xFF1A2A44),
    primaryDark: Color(0xFF6AADFF),
    background: Color(0xFF17171C),
    surface: Color(0xFF222228),
    textPrimary: Color(0xFFECEDF0),
    textSecondary: Color(0xFF9A9BA0),
    textTertiary: Color(0xFF6B6C71),
    textDisabled: Color(0xFF4A4B50),
    border: Color(0xFF333338),
    divider: Color(0xFF2A2A2F),
    success: Color(0xFF00D47E),
    error: Color(0xFFFF5A5A),
    warning: Color(0xFFFFAA33),
    gray100: Color(0xFF2A2A2F),
    gray200: Color(0xFF333338),
    gray300: Color(0xFF4A4B50),
    gray400: Color(0xFF6B6C71),
    gray500: Color(0xFF9A9BA0),
    gray600: Color(0xFFB0B1B5),
    gray700: Color(0xFFC8C9CC),
    gray800: Color(0xFFDCDDE0),
    gray900: Color(0xFFECEDF0),
  );
}

// ─────────────────────────────────────────────
// 앱 텍스트 스타일 스킴
// ─────────────────────────────────────────────
class AppTextStyleScheme {
  AppTextStyleScheme(AppColorScheme colors)
      : display1 = TextStyle(
          fontSize: 28, fontWeight: FontWeight.w700,
          color: colors.textPrimary, height: 1.3, letterSpacing: -0.5,
        ),
        heading1 = TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700,
          color: colors.textPrimary, height: 1.3, letterSpacing: -0.3,
        ),
        heading2 = TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600,
          color: colors.textPrimary, height: 1.4, letterSpacing: -0.3,
        ),
        heading3 = TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600,
          color: colors.textPrimary, height: 1.4,
        ),
        body1 = TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400,
          color: colors.textPrimary, height: 1.5,
        ),
        body1Medium = TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500,
          color: colors.textPrimary, height: 1.5,
        ),
        body2 = TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400,
          color: colors.textSecondary, height: 1.5,
        ),
        caption = TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400,
          color: colors.textTertiary, height: 1.4,
        ),
        label = TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500,
          color: colors.textSecondary, height: 1.4,
        );

  final TextStyle display1;
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle body1;
  final TextStyle body1Medium;
  final TextStyle body2;
  final TextStyle caption;
  final TextStyle label;
}

// ─────────────────────────────────────────────
// InheritedWidget으로 테마 주입
// ─────────────────────────────────────────────
class AppThemeScope extends InheritedWidget {
  final AppColorScheme colors;
  final AppTextStyleScheme textStyles;

  AppThemeScope({
    super.key,
    required bool isDark,
    required super.child,
  })  : colors = isDark ? AppColorScheme.dark : AppColorScheme.light,
        textStyles = AppTextStyleScheme(
          isDark ? AppColorScheme.dark : AppColorScheme.light,
        );

  static AppThemeScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeScope>()!;
  }

  @override
  bool updateShouldNotify(AppThemeScope oldWidget) {
    return colors != oldWidget.colors;
  }
}

// ─────────────────────────────────────────────
// BuildContext extension
// ─────────────────────────────────────────────
extension AppThemeExtension on BuildContext {
  AppColorScheme get appColors => AppThemeScope.of(this).colors;
  AppTextStyleScheme get appTextStyles => AppThemeScope.of(this).textStyles;
}

// ─────────────────────────────────────────────
// Cupertino 앱 테마 생성
// ─────────────────────────────────────────────
CupertinoThemeData buildAppTheme(AppColorScheme colors) {
  return CupertinoThemeData(
    primaryColor: colors.primary,
    primaryContrastingColor: colors.surface,
    scaffoldBackgroundColor: colors.background,
    barBackgroundColor: colors.surface,
    textTheme: CupertinoTextThemeData(
      primaryColor: colors.primary,
      navTitleTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        letterSpacing: -0.3,
      ),
      navLargeTitleTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: -0.5,
      ),
      textStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      navActionTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.primary,
      ),
      tabLabelTextStyle: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      pickerTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 21,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      dateTimePickerTextStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 21,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
    ),
  );
}
