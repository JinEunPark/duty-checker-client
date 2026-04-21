import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/presentation/view_model/connection_view_model.dart';
import 'package:duty_checker/core/date_time_utils.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widget/setting_button.dart';

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

  UserStatus _getUserStatus(Connection user) {
    if (user.latestCheckedAt == null) return UserStatus.critical;
    final hours =
        DateTime.now().difference(user.latestCheckedAt!).inMinutes / 60.0;
    if (hours <= 36) return UserStatus.normal;
    if (hours <= 48) return UserStatus.warning;
    return UserStatus.critical;
  }

  @override
  void initState() {
    super.initState();
    // 데이터 로드 완료 후 긴급 알림 체크 (1회만)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCriticalAlert();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(connectionViewModelProvider.notifier).refresh();
  }

  Future<void> _navigateToManagement() async {
    await context.push('/guardian/management');
    if (mounted) {
      ref.read(connectionViewModelProvider.notifier).refresh();
    }
  }

  void _checkCriticalAlert() {
    final state = ref.read(connectionViewModelProvider);
    final connectedUsers =
        state.connections.where((c) => c.isConnected).toList();
    final hasCritical =
        connectedUsers.any((u) => _getUserStatus(u) == UserStatus.critical);
    if (hasCritical && mounted && !_showCriticalAlert) {
      setState(() => _showCriticalAlert = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final connectionState = ref.watch(connectionViewModelProvider);
    final connectedUsers = connectionState.connections
        .where((c) => c.isConnected)
        .toList();

    // 데이터가 로드 완료되면 긴급 알림 및 연결 없음 확인
    ref.listen(connectionViewModelProvider, (prev, next) {
      if (prev?.isLoading == true && !next.isLoading) {
        _checkCriticalAlert();
      }
    });

    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      child: Stack(
        children: [
          SafeArea(
            child: connectionState.isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : connectedUsers.isNotEmpty
                    ? _buildMainContent(connectedUsers)
                    : _buildEmptyState(),
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

  Widget _buildMainContent(List<Connection> connectedUsers) {
    final textStyles = context.appTextStyles;

    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: _onRefresh,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // 인사말 + 설정
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('보호자 홈', style: textStyles.heading1),
                  const SettingButton(),
                ],
              ),
              const Gap(4),
              Text(
                '연결된 분의 안부를 확인해보세요',
                style: textStyles.body2,
              ),
              const Gap(24),

              // 당사자 관리 카드
              _ManagementCard(
                userCount: connectedUsers.length,
                onTap: _navigateToManagement,
              ),
              const Gap(20),

              // 당사자 상태 카드 목록
              ...connectedUsers.map((user) {
                final status = _getUserStatus(user);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _UserStatusCard(
                    user: user,
                    status: status,
                    lastCheckTimeText: user.latestCheckedAt?.formatRelative() ?? '기록 없음',
                  ),
                );
              }),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: _onRefresh,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(24),
                Align(
                  alignment: Alignment.centerRight,
                  child: const SettingButton(),
                ),
                const Spacer(flex: 2),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors.gray900.withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.person_2_fill,
                        size: 32,
                        color: colors.gray400,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      '아직 연결된 당사자가 없어요',
                      style: textStyles.heading2,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      '당사자에게 연결 요청을 보내거나,\n당사자의 요청을 수락하면 연결돼요',
                      style: textStyles.body2,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(24),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(12),
                      onPressed: _navigateToManagement,
                      child: Text(
                        '연결 요청하러 가기',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colors.surface,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ],
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
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colors.gray900.withValues(alpha: 0.05),
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
                color: colors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.person_2_fill,
                size: 20,
                color: colors.primary,
              ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '당사자 관리',
                    style: textStyles.heading3,
                  ),
                  const Gap(2),
                  Text(
                    '당사자 $userCount명 연결됨',
                    style: textStyles.body2,
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: colors.gray400,
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
  final Connection user;
  final UserStatus status;
  final String lastCheckTimeText;

  const _UserStatusCard({
    required this.user,
    required this.status,
    required this.lastCheckTimeText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final cfg = _getConfig(colors);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: cfg.borderColor != null
            ? Border.all(color: cfg.borderColor!, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: colors.gray900.withValues(alpha: 0.05),
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
                    user.name.isNotEmpty ? user.name[0] : '?',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Text(user.name, style: textStyles.heading3),
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
          Container(height: 1, color: colors.divider),
          const Gap(16),

          // 마지막 안부 확인 시각
          Text(
            '마지막 안부 확인',
            style: textStyles.caption,
          ),
          const Gap(4),
          Text(lastCheckTimeText, style: textStyles.heading3),

          const Gap(12),

          // 상태 메시지
          Text(cfg.message, style: textStyles.body2),

          const Gap(16),

          // 안내 텍스트
          Text(
            '필요 시 직접 연락해 주세요.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              color: colors.gray400,
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

  _StatusConfig _getConfig(AppColorScheme colors) {
    switch (status) {
      case UserStatus.normal:
        return _StatusConfig(
          label: null,
          message: '안부가 정상적으로 확인되고 있어요.',
          avatarBg: colors.primaryLight,
          borderColor: null,
          dotColor: colors.success,
          labelColor: null,
          labelBg: null,
        );
      case UserStatus.warning:
        return _StatusConfig(
          label: '주의',
          message: '아직 안부 확인이 되지 않았어요.',
          avatarBg: const Color(0xFFFFF5E6),
          borderColor: colors.warning,
          dotColor: colors.warning,
          labelColor: colors.warning,
          labelBg: const Color(0xFFFFF5E6),
        );
      case UserStatus.critical:
        return _StatusConfig(
          label: '긴급',
          message: '48시간 동안 안부 확인이 되지 않았습니다.',
          avatarBg: const Color(0xFFFFF5F5),
          borderColor: colors.error,
          dotColor: colors.error,
          labelColor: colors.error,
          labelBg: const Color(0xFFFFF5F5),
        );
    }
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
    final colors = context.appColors;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary ? colors.primary : colors.gray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? colors.surface : colors.textPrimary,
            ),
            const Gap(6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary ? colors.surface : colors.textPrimary,
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
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

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
                color: colors.surface,
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
                        child: Icon(
                          CupertinoIcons.exclamationmark_circle_fill,
                          size: 22,
                          color: colors.error,
                        ),
                      ),
                      const Gap(12),
                      Text(
                        '안부 미확인 알림',
                        style: textStyles.heading2,
                      ),
                    ],
                  ),
                  const Gap(16),
                  Text(
                    '48시간 동안 안부 확인이 되지 않았습니다.',
                    style: textStyles.body2,
                  ),
                  const Gap(24),
                  GestureDetector(
                    onTap: onDismiss,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: colors.textPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '확인',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors.surface,
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
