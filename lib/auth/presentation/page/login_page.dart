import 'package:duty_checker/auth/presentation/view_model/login_view_model.dart';
import 'package:duty_checker/core/fcm/fcm_service.dart';
import 'package:duty_checker/core/network/dio_provider.dart';
import 'package:duty_checker/core/shared_preferences_provider.dart';
import 'package:duty_checker/core/validators.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  static const _lastPhoneKey = 'last_login_phone';

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final savedPhone = ref.read(sharedPreferencesProvider).getString(_lastPhoneKey);
    if (savedPhone != null) {
      _phoneController.text = savedPhone;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final phone = _phoneController.text;
    final digits = phone.replaceAll('-', '');
    final password = _passwordController.text;

    if (phone.isEmpty) {
      _showAlert('전화번호 입력', '전화번호를 입력해주세요.');
      return;
    }
    if (!phoneRegex.hasMatch(digits)) {
      _showAlert('전화번호 확인', '올바른 전화번호를 입력해주세요.\n예: 010-1234-5678');
      return;
    }
    if (password.isEmpty) {
      _showAlert('비밀번호 입력', '비밀번호를 입력해주세요.');
      return;
    }

    ref.read(sharedPreferencesProvider).setString(_lastPhoneKey, phone);

    await ref.read(loginViewModelProvider.notifier).login(
          phone: digits,
          password: password,
        );
  }

  void _showAlert(String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginViewModelProvider, (prev, next) {
      if (next.error != null) {
        _showAlert('로그인 실패', next.error!);
        return;
      }
      final user = next.user;
      if (user != null) {
        ref.read(fcmServiceProvider).connectApi(ref.read(dioProvider));
        context.go(user.isGuardian ? '/guardian/home' : '/user/home');
      }
    });

    return CupertinoPageScaffold(
      backgroundColor: context.appColors.background,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상단 영역 (아이콘 + 타이틀 + 로그인 카드)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(48),

                        // 앱 아이콘
                        Center(
                          child: SvgPicture.asset(
                            'assets/icons/icon_morse_dark.svg',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const Gap(16),
                        Center(
                          child: Text(
                            '모스',
                            style: context.appTextStyles.heading1.copyWith(
                              color: context.appColors.primary,
                              letterSpacing: 2,
                            ),
                          ),
                        ),

                        const Gap(48),

                        // 타이틀
                        Text(
                          '안녕하세요',
                          style: context.appTextStyles.display1,
                        ),
                        const Gap(12),
                        Text(
                          '전화번호와 비밀번호를 입력해주세요',
                          style: context.appTextStyles.body2,
                        ),
                        const Gap(28),

                        // 로그인 카드
                        Container(
                          decoration: BoxDecoration(
                            color: context.appColors.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // 전화번호
                              CupertinoTextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                placeholder: '전화번호',
                                placeholderStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 16,
                                  color: context.appColors.textTertiary,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 16,
                                  color: context.appColors.textPrimary,
                                ),
                                decoration: BoxDecoration(
                                  color: context.appColors.gray100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  _PhoneFormatter(),
                                ],
                                onSubmitted: (_) =>
                                    _passwordFocusNode.requestFocus(),
                              ),
                              const Gap(10),

                              // 비밀번호
                              CupertinoTextField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                obscureText: _obscurePassword,
                                placeholder: '비밀번호',
                                placeholderStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 16,
                                  color: context.appColors.textTertiary,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 16,
                                  color: context.appColors.textPrimary,
                                ),
                                decoration: BoxDecoration(
                                  color: context.appColors.gray100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 16,
                                  bottom: 16,
                                  right: 6,
                                ),
                                suffix: CupertinoButton(
                                  padding: const EdgeInsets.only(right: 10),
                                  minimumSize: Size.zero,
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                  child: Icon(
                                    _obscurePassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                    size: 20,
                                    color: context.appColors.textTertiary,
                                  ),
                                ),
                                suffixMode: OverlayVisibilityMode.always,
                              ),
                              const Gap(16),

                              // 로그인 버튼
                              GestureDetector(
                                onTap: _onLogin,
                                child: Container(
                                  width: double.infinity,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: context.appColors.primary,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '로그인',
                                      style: context.appTextStyles.body1Medium.copyWith(
                                        color: context.appColors.surface,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(12),

                              // 비밀번호 찾기
                              Align(
                                alignment: Alignment.centerRight,
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  onPressed: () => context.push('/reset-password'),
                                  child: Text(
                                    '비밀번호를 잊으셨나요?',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: context.appColors.textTertiary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // 하단 회원가입 안내
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 24),
                      child: Center(
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => context.go('/landing'),
                          child: Text.rich(
                            TextSpan(
                              text: '계정이 없으신가요? ',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: context.appColors.textTertiary,
                              ),
                              children: [
                                TextSpan(
                                  text: '회원가입',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: context.appColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 전화번호 자동 포매터 (010-XXXX-XXXX)
// ─────────────────────────────────────────────
class _PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll('-', '');
    final limited = digits.length > 11 ? digits.substring(0, 11) : digits;

    String formatted;
    if (limited.length <= 3) {
      formatted = limited;
    } else if (limited.length <= 7) {
      formatted = '${limited.substring(0, 3)}-${limited.substring(3)}';
    } else {
      formatted =
          '${limited.substring(0, 3)}-${limited.substring(3, 7)}-${limited.substring(7)}';
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
