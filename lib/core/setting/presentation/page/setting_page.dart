import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/core/network/token_storage.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  bool _isNotificationOn = true;

  void _onLogout() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠어요?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('취소'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('로그아웃'),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref.read(logoutUseCaseProvider).call();
              } catch (e) {
                // 서버 로그아웃 실패해도 로컬 토큰은 이미 삭제됨 (RepositoryImpl에서 처리)
                // 네트워크 오류 등의 경우에도 로그인 화면으로 이동
              }
              if (mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }

  void _onDeleteAccount() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('회원 탈퇴'),
        content: const Text(
          '탈퇴하면 모든 데이터가 삭제되며\n복구할 수 없어요. 정말 탈퇴하시겠어요?',
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('취소'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('탈퇴하기'),
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: 회원 탈퇴 API 호출
              ref.read(tokenStorageProvider).clear();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.appColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.pop(),
                    child: Icon(
                      CupertinoIcons.back,
                      color: context.appColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '설정',
                      style: context.appTextStyles.heading3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            const Gap(8),

            // 설정 리스트
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // 앱 설정 섹션
                  const _SectionHeader(title: '앱 설정'),
                  _SettingsCard(
                    children: [
                      _ToggleItem(
                        icon: CupertinoIcons.moon_fill,
                        iconColor: const Color(0xFF6E56CF),
                        title: '다크 모드',
                        value: ref.watch(themeModeProvider),
                        onChanged: (v) => ref.read(themeModeProvider.notifier).toggle(v),
                      ),
                      const _Divider(),
                      _ToggleItem(
                        icon: CupertinoIcons.bell_fill,
                        iconColor: context.appColors.warning,
                        title: '알림',
                        subtitle: '안부 확인 알림을 받을 수 있어요',
                        value: _isNotificationOn,
                        onChanged: (v) =>
                            setState(() => _isNotificationOn = v),
                      ),
                    ],
                  ),
                  const Gap(24),

                  // 계정 섹션
                  const _SectionHeader(title: '계정'),
                  _SettingsCard(
                    children: [
                      _TapItem(
                        icon: CupertinoIcons.arrow_right_arrow_left,
                        iconColor: context.appColors.primary,
                        title: '사용자 권한 전환',
                        subtitle: '당사자 / 보호자 전환',
                        onTap: () {
                          // TODO: 권한 전환 로직
                        },
                      ),
                      const _Divider(),
                      _TapItem(
                        icon: CupertinoIcons.square_arrow_right,
                        iconColor: context.appColors.gray600,
                        title: '로그아웃',
                        onTap: _onLogout,
                      ),
                    ],
                  ),
                  const Gap(24),

                  // 위험 영역
                  const _SectionHeader(title: '기타'),
                  _SettingsCard(
                    children: [
                      _TapItem(
                        icon: CupertinoIcons.info_circle,
                        iconColor: context.appColors.gray500,
                        title: '앱 버전',
                        trailing: Text(
                          '1.0.0',
                          style: context.appTextStyles.body2.copyWith(
                            color: context.appColors.textTertiary,
                          ),
                        ),
                      ),
                      const _Divider(),
                      _TapItem(
                        icon: CupertinoIcons.trash,
                        iconColor: context.appColors.error,
                        title: '회원 탈퇴',
                        titleColor: context.appColors.error,
                        onTap: _onDeleteAccount,
                      ),
                    ],
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 섹션 헤더
// ─────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: context.appTextStyles.label.copyWith(color: context.appColors.textTertiary),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 카드 컨테이너
// ─────────────────────────────────────────────
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.appColors.gray900.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// ─────────────────────────────────────────────
// 토글 항목
// ─────────────────────────────────────────────
class _ToggleItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _IconBadge(icon: icon, color: iconColor),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.appTextStyles.body1Medium),
                if (subtitle != null) ...[
                  const Gap(2),
                  Text(subtitle!, style: context.appTextStyles.caption),
                ],
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: context.appColors.primary,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 탭 항목
// ─────────────────────────────────────────────
class _TapItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color? titleColor;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _TapItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.titleColor,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _IconBadge(icon: icon, color: iconColor),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.appTextStyles.body1Medium.copyWith(
                      color: titleColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const Gap(2),
                    Text(subtitle!, style: context.appTextStyles.caption),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                CupertinoIcons.chevron_right,
                size: 16,
                color: context.appColors.gray400,
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 아이콘 뱃지
// ─────────────────────────────────────────────
class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBadge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}

// ─────────────────────────────────────────────
// 구분선
// ─────────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(height: 1, color: context.appColors.divider),
    );
  }
}
