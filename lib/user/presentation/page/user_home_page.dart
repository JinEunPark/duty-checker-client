import 'package:duty_checker/shared/widget/settings_action_sheet.dart';
import 'package:duty_checker/theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// ─────────────────────────────────────────────
// 당사자 홈 페이지
// ─────────────────────────────────────────────
class UserHomePage extends ConsumerStatefulWidget {
  const UserHomePage({super.key});

  @override
  ConsumerState<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends ConsumerState<UserHomePage>
    with TickerProviderStateMixin {
  DateTime? _lastCheckTime;
  bool _justChecked = false;

  late final AnimationController _tapCtrl;
  late final Animation<double> _scaleAnim;

  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  // TODO: 실제 데이터로 교체
  final int _pendingGuardians = 1;
  final int _activeGuardians = 0;

  @override
  void initState() {
    super.initState();
    _tapCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _tapCtrl, curve: Curves.easeInOut),
    );

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _tapCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _onCheckIn() {
    if (_justChecked) return;

    setState(() {
      _justChecked = true;
      _lastCheckTime = DateTime.now();
    });

    _pulseCtrl.stop();

    // TODO: 서버에 안부 확인 요청

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() => _justChecked = false);
        _pulseCtrl.repeat(reverse: true);
      }
    });
  }

  String _formatLastCheckTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    final minutes = diff.inMinutes;

    if (minutes < 1) return '방금 전';
    if (minutes < 60) return '$minutes분 전';

    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;

    final period = date.hour < 12 ? '오전' : '오후';
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final timeStr = '$period $hour:$minute';

    if (isToday) return '오늘 $timeStr';

    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;

    if (isYesterday) return '어제 $timeStr';
    return '${date.month}월 ${date.day}일 $timeStr';
  }

  String _getConnectionStatusText() {
    if (_pendingGuardians > 0 && _activeGuardians == 0) {
      return '보호자 $_pendingGuardians명 연결 대기 중';
    }
    if (_activeGuardians > 0 && _pendingGuardians == 0) {
      return '보호자 $_activeGuardians명 연결됨';
    }
    if (_pendingGuardians > 0 && _activeGuardians > 0) {
      return '보호자 $_activeGuardians명 연결됨, $_pendingGuardians명 대기 중';
    }
    return '아직 보호자가 등록되지 않았어요';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Gap(24),

              // 타이틀 + 설정
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('안부 전달', style: AppTextStyles.heading1),
                  const SettingsDropdown(currentRole: UserRole.user),
                ],
              ),
              const Gap(4),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '보호자에게 안부를 전달할 수 있어요',
                  style: AppTextStyles.body2,
                ),
              ),
              const Gap(24),

              // 보호자 관리 카드
              _GuardianManagementCard(
                statusText: _getConnectionStatusText(),
                onTap: () => context.push('/user/guardian-management'),
              ),

              // 안부 확인 영역
              Expanded(
                child: Align(
                alignment: const Alignment(0, -0.25),
                child: SingleChildScrollView(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 펄스 링 + 체크인 버튼
                    GestureDetector(
                      onTapDown: (_) => _tapCtrl.forward(),
                      onTapUp: (_) {
                        _tapCtrl.reverse();
                        _onCheckIn();
                      },
                      onTapCancel: () => _tapCtrl.reverse(),
                      child: ScaleTransition(
                        scale: _scaleAnim,
                        child: SizedBox(
                          width: 220,
                          height: 220,
                          child: AnimatedBuilder(
                            animation: _pulseAnim,
                            builder: (context, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // 펄스 링
                                  if (!_justChecked)
                                    Transform.scale(
                                      scale:
                                          1.0 + (0.03 * _pulseAnim.value),
                                      child: Container(
                                        width: 210,
                                        height: 210,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primary
                                                .withValues(
                                              alpha: 0.06 +
                                                  (0.1 *
                                                      _pulseAnim.value),
                                            ),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  // 메인 원형 버튼
                                  child!,
                                ],
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                color: _justChecked
                                    ? AppColors.primary
                                    : AppColors.surface,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _justChecked
                                        ? AppColors.primary
                                            .withValues(alpha: 0.25)
                                        : AppColors.gray900
                                            .withValues(alpha: 0.06),
                                    blurRadius: _justChecked ? 24 : 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: AnimatedSwitcher(
                                duration:
                                    const Duration(milliseconds: 200),
                                child: Icon(
                                  _justChecked
                                      ? CupertinoIcons.checkmark
                                      : CupertinoIcons.heart_fill,
                                  key: ValueKey(_justChecked),
                                  size: 52,
                                  color: _justChecked
                                      ? AppColors.surface
                                      : AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(28),

                    // 타이틀
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        _justChecked ? '안부가 전달되었어요' : '안부 확인',
                        key: ValueKey('title_$_justChecked'),
                        style: AppTextStyles.heading2,
                      ),
                    ),
                    const Gap(10),

                    // 상태 텍스트 또는 마지막 안부 칩
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _justChecked
                          ? const Text(
                              '보호자에게 안부가 전달됩니다',
                              key: ValueKey('sent'),
                              style: AppTextStyles.body2,
                            )
                          : _lastCheckTime != null
                              ? _LastCheckChip(
                                  key: const ValueKey('chip'),
                                  text: _formatLastCheckTime(
                                    _lastCheckTime!,
                                  ),
                                )
                              : const Text(
                                  '눌러서 안부를 전달해주세요',
                                  key: ValueKey('guide'),
                                  style: AppTextStyles.body2,
                                ),
                    ),
                  ],
                ),
                ),
              ),
              ),

              // 하단 안내
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  '안부는 하루 기준으로 보호자에게 전달돼요',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.gray400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 마지막 안부 확인 칩
// ─────────────────────────────────────────────
class _LastCheckChip extends StatelessWidget {
  final String text;
  const _LastCheckChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray900.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const Gap(8),
          Text(
            '마지막 안부  $text',
            style: AppTextStyles.label,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 보호자 관리 카드
// ─────────────────────────────────────────────
class _GuardianManagementCard extends StatelessWidget {
  final String statusText;
  final VoidCallback onTap;

  const _GuardianManagementCard({
    required this.statusText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray900.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.person_2_fill,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '보호자 관리',
                    style: AppTextStyles.heading3,
                  ),
                  const Gap(2),
                  Text(statusText, style: AppTextStyles.body2),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}
