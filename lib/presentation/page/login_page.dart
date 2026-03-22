import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _isOtherAccount = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_passwordController.text.isEmpty) return;
    if (_isOtherAccount) {
      final digits = _phoneController.text.replaceAll('-', '');
      if (digits.length < 10) return;
    }
    // TODO: 실제 인증 후 역할별 분기
    context.go('/user/home');
  }

  void _switchToOtherAccount() {
    setState(() {
      _isOtherAccount = true;
      _phoneController.clear();
      _passwordController.clear();
    });
  }

  void _switchBack() {
    setState(() {
      _isOtherAccount = false;
      _phoneController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),

              // 타이틀
              Text(
                _isOtherAccount ? '다른 계정으로\n로그인' : '다시 오셨군요',
                style: AppTextStyles.display1,
              ),
              const Gap(12),
              Text(
                _isOtherAccount
                    ? '전화번호와 비밀번호를 입력해주세요'
                    : '비밀번호를 입력해주세요',
                style: AppTextStyles.body2,
              ),

              const Spacer(flex: 2),

              // 로그인 카드
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 전화번호 (다른 계정 모드)
                    if (_isOtherAccount) ...[
                      CupertinoTextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        placeholder: '전화번호',
                        placeholderStyle: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                          color: AppColors.textTertiary,
                        ),
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
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
                    ],

                    // 비밀번호
                    CupertinoTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      placeholder: '비밀번호',
                      placeholderStyle: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        color: AppColors.textTertiary,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    const Gap(16),

                    // 로그인 버튼
                    GestureDetector(
                      onTap: _onLogin,
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            '로그인',
                            style: AppTextStyles.body1Medium.copyWith(
                              color: AppColors.surface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // 하단 토글 버튼
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed:
                      _isOtherAccount ? _switchBack : _switchToOtherAccount,
                  child: Text(
                    _isOtherAccount ? '이전 계정으로 돌아가기' : '다른 계정으로 로그인',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const Gap(16),
            ],
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
