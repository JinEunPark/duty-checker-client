import 'package:flutter/cupertino.dart';

// ─────────────────────────────────────────────
// 앱 색상 팔레트
// 토스 디자인 시스템 기반
// ─────────────────────────────────────────────
class AppColors {
  AppColors._();

  // Primary - 토스 블루
  static const Color primary = Color(0xFF3182F6);
  static const Color primaryLight = Color(0xFFEBF3FF);
  static const Color primaryDark = Color(0xFF1B64DA);

  // Background
  static const Color background = Color(0xFFF2F4F6);  // 화면 배경
  static const Color surface = Color(0xFFFFFFFF);      // 카드, 시트 배경

  // Text
  static const Color textPrimary = Color(0xFF191F28);   // 본문 주요 텍스트
  static const Color textSecondary = Color(0xFF6B7684); // 보조 텍스트
  static const Color textTertiary = Color(0xFF8B95A1);  // 힌트, 비활성 텍스트
  static const Color textDisabled = Color(0xFFB0B8C1);  // 비활성화 텍스트

  // Border & Divider
  static const Color border = Color(0xFFE5E8EB);
  static const Color divider = Color(0xFFF2F4F6);

  // Status
  static const Color success = Color(0xFF00C471);  // 성공
  static const Color error = Color(0xFFF04452);    // 오류
  static const Color warning = Color(0xFFFF9500);  // 경고

  // Grayscale
  static const Color gray100 = Color(0xFFF2F4F6);
  static const Color gray200 = Color(0xFFE5E8EB);
  static const Color gray300 = Color(0xFFD1D6DB);
  static const Color gray400 = Color(0xFFB0B8C1);
  static const Color gray500 = Color(0xFF8B95A1);
  static const Color gray600 = Color(0xFF6B7684);
  static const Color gray700 = Color(0xFF4E5968);
  static const Color gray800 = Color(0xFF333D4B);
  static const Color gray900 = Color(0xFF191F28);
}

// ─────────────────────────────────────────────
// 앱 텍스트 스타일
// Pretendard 폰트 기반
// ─────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  // Display
  static const TextStyle display1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.5,
  );

  // Heading
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: -0.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle body1Medium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  // Label
  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );
}

// ─────────────────────────────────────────────
// Cupertino 앱 테마
// ─────────────────────────────────────────────
const CupertinoThemeData appTheme = CupertinoThemeData(
  primaryColor: AppColors.primary,
  primaryContrastingColor: AppColors.surface,
  scaffoldBackgroundColor: AppColors.background,
  barBackgroundColor: AppColors.surface,
  textTheme: CupertinoTextThemeData(
    primaryColor: AppColors.primary,

    // 네비게이션 바 타이틀
    navTitleTextStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      letterSpacing: -0.3,
    ),

    // 네비게이션 바 Large 타이틀
    navLargeTitleTextStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      letterSpacing: -0.5,
    ),

    // 기본 텍스트
    textStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),

    // 액션 버튼 텍스트 (네비게이션 바 버튼 등)
    navActionTextStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
    ),

    // 탭바 텍스트
    tabLabelTextStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),

    // 피커 텍스트
    pickerTextStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 21,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),

    // DatePicker 텍스트
    dateTimePickerTextStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 21,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
  ),
);
