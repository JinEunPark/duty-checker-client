import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/presentation/view_model/connection_view_model.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// ─────────────────────────────────────────────
// 당사자 관리 페이지 (보호자 → 당사자)
// ─────────────────────────────────────────────
class UserManagementPage extends ConsumerStatefulWidget {
  const UserManagementPage({super.key});

  @override
  ConsumerState<UserManagementPage> createState() =>
      _UserManagementPageState();
}

class _UserManagementPageState extends ConsumerState<UserManagementPage> {
  String? _toastMessage;

  void _showToast(String message) {
    setState(() => _toastMessage = message);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _toastMessage = null);
    });
  }

  // ── 닉네임 편집 ──
  void _editNickname(Connection user) {
    final controller = TextEditingController(text: user.name);
    final colors = context.appColors;

    showCupertinoDialog<void>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('호칭 편집'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controller,
            placeholder: '예: 어머니, 아버지',
            autofocus: true,
            maxLength: 10,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              color: colors.textPrimary,
            ),
            placeholderStyle: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              color: colors.textTertiary,
            ),
            decoration: BoxDecoration(
              color: colors.gray100,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () {
              controller.dispose();
              Navigator.of(ctx).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('저장'),
            onPressed: () {
              final newNickname = controller.text.trim();
              if (newNickname.isNotEmpty) {
                ref
                    .read(connectionViewModelProvider.notifier)
                    .updateConnectionName(id: user.id, name: newNickname);
                _showToast('호칭이 변경되었습니다');
              }
              controller.dispose();
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final connectionState = ref.watch(connectionViewModelProvider);
    final connectedUsers =
        connectionState.connections.where((c) => c.isConnected).toList();
    final pendingUsers =
        connectionState.connections.where((c) => c.isPending).toList();
    final hasContent = connectedUsers.isNotEmpty || pendingUsers.isNotEmpty;

    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: colors.surface,
        padding: const EdgeInsetsDirectional.only(start: 4, end: 8),
        border: Border(
          bottom: BorderSide(color: colors.border, width: 0.5),
        ),
        middle: Text(
          '연결 관리',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.chevron_left,
            color: colors.textPrimary,
          ),
        ),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: connectionState.isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : hasContent
                    ? _buildContent(connectedUsers, pendingUsers)
                    : _buildEmptyState(),
          ),

          // 토스트
          if (_toastMessage != null)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 24,
              left: 0,
              right: 0,
              child: _Toast(message: _toastMessage!),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(
    List<Connection> connectedUsers,
    List<Connection> pendingUsers,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        // ── 연결된 분 ──
        if (connectedUsers.isNotEmpty) ...[
          _SectionHeader(
            title: '연결된 분',
            count: connectedUsers.length,
          ),
          const Gap(10),
          ...connectedUsers.map(
            (user) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ConnectedUserCard(
                user: user,
                onEditNickname: () => _editNickname(user),
              ),
            ),
          ),
          const Gap(8),
        ],

        // ── 대기 중인 연결 ──
        if (pendingUsers.isNotEmpty) ...[
          _SectionHeader(
            title: '대기 중인 연결',
            count: pendingUsers.length,
          ),
          const Gap(10),
          ...pendingUsers.map(
            (user) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PendingUserCard(user: user),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

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
                color: colors.gray100,
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
              '아직 연결이 없어요',
              style: textStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            Text(
              '당사자가 보호자로 등록하면\n이곳에서 연결을 수락할 수 있습니다',
              style: textStyles.body2,
              textAlign: TextAlign.center,
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
  final int count;

  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Text(
      '$title ($count)',
      style: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colors.textSecondary,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 연결된 당사자 카드
// ─────────────────────────────────────────────
class _ConnectedUserCard extends StatelessWidget {
  final Connection user;
  final VoidCallback onEditNickname;

  const _ConnectedUserCard({
    required this.user,
    required this.onEditNickname,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final displayName = user.name;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.primaryLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // 아바타
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colors.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                displayName.isNotEmpty ? displayName[0] : '?',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                ),
              ),
            ),
          ),
          const Gap(14),

          // 이름 + 전화번호
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: textStyles.heading3,
                ),
                const Gap(2),
                Text(
                  user.phone,
                  style: textStyles.body2,
                ),
              ],
            ),
          ),

          // 편집 버튼
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onEditNickname,
            child: Icon(
              CupertinoIcons.pencil,
              size: 18,
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 대기 중 카드
// ─────────────────────────────────────────────
class _PendingUserCard extends StatelessWidget {
  final Connection user;

  const _PendingUserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border, width: 1.5),
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
              color: colors.gray100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.person_fill,
              size: 22,
              color: colors.gray400,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.phone, style: textStyles.heading3),
                const Gap(2),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      '연결 대기 중',
                      style: textStyles.caption.copyWith(
                        color: colors.warning,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 토스트 알림
// ─────────────────────────────────────────────
class _Toast extends StatelessWidget {
  final String message;
  const _Toast({required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: colors.gray900,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors.gray900.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.checkmark_circle_fill,
              size: 16,
              color: colors.surface,
            ),
            const Gap(8),
            Text(
              message,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colors.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
