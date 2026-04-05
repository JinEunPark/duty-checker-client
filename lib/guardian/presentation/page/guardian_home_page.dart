import 'package:duty_checker/shared/widget/settings_action_sheet.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────
// 모델
// ─────────────────────────────────────────────
class ConnectedUser {
  final String id;
  final String nickname;
  final String phone;
  final DateTime? lastCheckIn;

  const ConnectedUser({
    required this.id,
    required this.nickname,
    required this.phone,
    this.lastCheckIn,
  });
}

enum UserStatus { normal, warning, critical }

String _toInternational(String phone) {
  final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
  return digits.startsWith('0') ? '+82${digits.substring(1)}' : '+$digits';
}

Future<void> _launchPhone(String phone) async {
  final uri = Uri.parse('tel:${_toInternational(phone)}');
  await launchUrl(uri, mode: LaunchMode.platformDefault);
}

Future<void> _launchSms(String phone) async {
  final uri = Uri(scheme: 'sms', path: _toInternational(phone));
  await launchUrl(uri, mode: LaunchMode.platformDefault);
}
// ─────────────────────────────────────────────
// 보호자 홈 페이지
// ─────────────────────────────────────────────
class GuardianHomePage extends ConsumerStatefulWidget {
  const GuardianHomePage({super.key});

  @override
  ConsumerState<GuardianHomePage> createState() => _GuardianHomePageState();
}

class _GuardianHomePageState extends ConsumerState<GuardianHomePage> {
  bool _showCriticalAlert = false;

  // TODO: 실제 데이터로 교체
  final List<ConnectedUser> _connectedUsers = [
    ConnectedUser(
      id: '1',
      nickname: '홍길동',
      phone: '010-1234-5678',
      lastCheckIn: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ConnectedUser(
      id: '2',
      nickname: '이순신',
      phone: '010-9876-5432',
      lastCheckIn: DateTime.now().subtract(const Duration(hours: 40)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hasCritical = _connectedUsers.any(
        (u) => _getUserStatus(u) == UserStatus.critical,
      );
      if (hasCritical) setState(() => _showCriticalAlert = true);
    });
  }

  UserStatus _getUserStatus(ConnectedUser user) {
    if (user.lastCheckIn == null) return UserStatus.critical;
    final hours =
        DateTime.now().difference(user.lastCheckIn!).inMinutes / 60.0;
    if (hours <= 36) return UserStatus.normal;
    if (hours <= 48) return UserStatus.warning;
    return UserStatus.critical;
  }

  String _formatLastCheckTime(DateTime? date) {
    if (date == null) return '기록 없음';

    final now = DateTime.now();
    final diff = now.difference(date);
    final minutes = diff.inMinutes;

    if (minutes < 1) return '방금 전';
    if (minutes < 60) return '$minutes분 전';

    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;

    final period = date.hour < 12 ? '오전' : '오후';
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final timeStr = '$period $hour:$minute';

    if (isToday) return '오늘 $timeStr';
    if (isYesterday) return '어제 $timeStr';
    return '${date.month}월 ${date.day}일 $timeStr';
  }

  @override
  Widget build(BuildContext context) {
    final hasUsers = _connectedUsers.isNotEmpty;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: Stack(
        children: [
          SafeArea(
            child: hasUsers ? _buildMainContent() : _buildEmptyState(),
          ),

          // 긴급 알림 팝업
          if (_showCriticalAlert)
            _CriticalAlertOverlay(
              onDismiss: () => setState(() => _showCriticalAlert = false),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        // 인사말 + 설정
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('보호자 홈', style: AppTextStyles.heading1),
            const SettingsDropdown(currentRole: UserRole.guardian),
          ],
        ),
        const Gap(4),
        const Text(
          '연결된 분의 안부를 확인해보세요',
          style: AppTextStyles.body2,
        ),
        const Gap(24),

        // 당사자 관리 카드
        _ManagementCard(
          userCount: _connectedUsers.length,
          onTap: () => context.push('/guardian/management'),
        ),
        const Gap(20),

        // 당사자 상태 카드 목록
        ..._connectedUsers.map((user) {
          final status = _getUserStatus(user);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _UserStatusCard(
              user: user,
              status: status,
              lastCheckTimeText: _formatLastCheckTime(user.lastCheckIn),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray900.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.person_2_fill,
                size: 32,
                color: AppColors.gray400,
              ),
            ),
            const Gap(20),
            const Text(
              '아직 연결된 분이 없어요',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            const Text(
              '안부를 확인할 분이 등록되면\n이곳에서 상태를 확인할 수 있어요.',
              style: AppTextStyles.body2,
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            Container(
              width: double.infinity,
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
              child: Column(
                children: [
                  const Text(
                    '안부 확인 요청을 기다리고 있어요',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(6),
                  const Text(
                    '당사자가 등록하면 자동으로 알려드릴게요',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
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
// 당사자 관리 카드
// ─────────────────────────────────────────────
class _ManagementCard extends StatelessWidget {
  final int userCount;
  final VoidCallback onTap;

  const _ManagementCard({required this.userCount, required this.onTap});

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
              decoration: BoxDecoration(
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
                    '당사자 관리',
                    style: AppTextStyles.heading3,
                  ),
                  const Gap(2),
                  Text(
                    '당사자 $userCount명 연결됨',
                    style: AppTextStyles.body2,
                  ),
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

// ─────────────────────────────────────────────
// 당사자 상태 카드
// ─────────────────────────────────────────────
class _UserStatusCard extends StatelessWidget {
  final ConnectedUser user;
  final UserStatus status;
  final String lastCheckTimeText;

  const _UserStatusCard({
    required this.user,
    required this.status,
    required this.lastCheckTimeText,
  });

  _StatusConfig get _config {
    switch (status) {
      case UserStatus.normal:
        return _StatusConfig(
          label: null,
          message: '안부가 정상적으로 확인되고 있어요.',
          avatarBg: AppColors.primaryLight,
          borderColor: null,
          dotColor: AppColors.success,
          labelColor: null,
          labelBg: null,
        );
      case UserStatus.warning:
        return _StatusConfig(
          label: '주의',
          message: '아직 안부 확인이 되지 않았어요.',
          avatarBg: const Color(0xFFFFF5E6),
          borderColor: AppColors.warning,
          dotColor: AppColors.warning,
          labelColor: AppColors.warning,
          labelBg: const Color(0xFFFFF5E6),
        );
      case UserStatus.critical:
        return _StatusConfig(
          label: '긴급',
          message: '48시간 동안 안부 확인이 되지 않았습니다.',
          avatarBg: const Color(0xFFFFF5F5),
          borderColor: AppColors.error,
          dotColor: AppColors.error,
          labelColor: AppColors.error,
          labelBg: const Color(0xFFFFF5F5),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cfg = _config;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: cfg.borderColor != null
            ? Border.all(color: cfg.borderColor!, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray900.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더: 아바타 + 이름 + 상태 라벨
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cfg.avatarBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    user.nickname.isNotEmpty ? user.nickname[0] : '?',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Text(user.nickname, style: AppTextStyles.heading3),
              const Spacer(),
              if (cfg.label != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: cfg.labelBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: cfg.dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        cfg.label!,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cfg.labelColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const Gap(16),
          Container(height: 1, color: AppColors.divider),
          const Gap(16),

          // 마지막 안부 확인 시각
          const Text(
            '마지막 안부 확인',
            style: AppTextStyles.caption,
          ),
          const Gap(4),
          Text(lastCheckTimeText, style: AppTextStyles.heading3),

          const Gap(12),

          // 상태 메시지
          Text(cfg.message, style: AppTextStyles.body2),

          const Gap(16),

          // 안내 텍스트
          const Text(
            '필요 시 직접 연락해 주세요.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              color: AppColors.gray400,
            ),
          ),
          const Gap(10),

          // 전화 / 문자 버튼
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: '전화하기',
                  icon: CupertinoIcons.phone_fill,
                  isPrimary: true,
                  onTap: () => _launchPhone(user.phone),
                ),
              ),
              const Gap(10),
              Expanded(
                child: _ActionButton(
                  label: '문자 보내기',
                  icon: CupertinoIcons.chat_bubble_fill,
                  isPrimary: false,
                  onTap: () => _launchSms(user.phone),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusConfig {
  final String? label;
  final String message;
  final Color avatarBg;
  final Color? borderColor;
  final Color dotColor;
  final Color? labelColor;
  final Color? labelBg;

  const _StatusConfig({
    required this.label,
    required this.message,
    required this.avatarBg,
    required this.borderColor,
    required this.dotColor,
    required this.labelColor,
    required this.labelBg,
  });
}

// ─────────────────────────────────────────────
// 액션 버튼 (전화 / 문자)
// ─────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.gray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? AppColors.surface : AppColors.textPrimary,
            ),
            const Gap(6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary ? AppColors.surface : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 긴급 알림 팝업 오버레이
// ─────────────────────────────────────────────
class _CriticalAlertOverlay extends StatelessWidget {
  final VoidCallback onDismiss;
  const _CriticalAlertOverlay({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: const Color(0x80000000),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // 팝업 내부 탭 무시
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF5F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.exclamationmark_circle_fill,
                          size: 22,
                          color: AppColors.error,
                        ),
                      ),
                      const Gap(12),
                      const Text(
                        '안부 미확인 알림',
                        style: AppTextStyles.heading2,
                      ),
                    ],
                  ),
                  const Gap(16),
                  const Text(
                    '48시간 동안 안부 확인이 되지 않았습니다.',
                    style: AppTextStyles.body2,
                  ),
                  const Gap(24),
                  GestureDetector(
                    onTap: onDismiss,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          '확인',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.surface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
