import 'package:duty_checker/core/widget/sign_up_widgets.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpCompletePage extends StatelessWidget {
  const SignUpCompletePage({
    super.key,
    required this.phone,
    required this.role,
    this.guardianCount = 0,
    this.autoLoggedIn = false,
  });

  final String phone;
  final String role;
  final int guardianCount;
  final bool autoLoggedIn;

  bool get _isGuardian => role == 'GUARDIAN';

  String get _nextRoute {
    if (!autoLoggedIn) return '/login';
    return _isGuardian ? '/guardian/home' : '/user/home';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.appColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: context.appColors.surface,
        border: Border(
          bottom: BorderSide(color: context.appColors.border, width: 0.5),
        ),
        middle: Text(
          '가입 완료',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: context.appColors.textPrimary,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: context.appColors.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.appColors.gray900
                                  .withValues(alpha: 0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.checkmark,
                          size: 48,
                          color: context.appColors.primary,
                        ),
                      ),
                      const Gap(24),
                      Text('가입이 완료되었습니다',
                          style: context.appTextStyles.display1),
                      const Gap(16),
                      Text(
                        _isGuardian
                            ? '보호자로 가입되었습니다\n당사자의 안부를 확인할 수 있어요'
                            : '안부 확인 서비스를 시작합니다\n등록하신 보호자에게 알림이 전송됩니다',
                        textAlign: TextAlign.center,
                        style:
                            context.appTextStyles.body2.copyWith(height: 1.6),
                      ),
                      const Gap(40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: context.appColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: context.appColors.gray900
                                  .withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text('본인 전화번호',
                                    style: context.appTextStyles.body2
                                        .copyWith(fontSize: 15)),
                                Text(phone,
                                    style: context.appTextStyles.body1Medium
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 16),
                              height: 1,
                              color: context.appColors.divider,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text('가입 유형',
                                    style: context.appTextStyles.body2
                                        .copyWith(fontSize: 15)),
                                Text(_isGuardian ? '보호자' : '당사자',
                                    style: context.appTextStyles.body1Medium
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                            if (!_isGuardian) ...[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                height: 1,
                                color: context.appColors.divider,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('보호자',
                                      style: context.appTextStyles.body2
                                          .copyWith(fontSize: 15)),
                                  Text('$guardianCount명',
                                      style: context.appTextStyles.body1Medium
                                          .copyWith(fontSize: 15)),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: SignUpCompleteButton(
                enabled: true,
                label: '시작하기',
                onTap: () => context.go(_nextRoute),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
