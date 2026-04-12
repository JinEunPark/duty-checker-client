import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/presentation/view_model/connection_view_model.dart';
import 'package:duty_checker/core/widget/connection_widgets.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class GuardianManagementPage extends ConsumerStatefulWidget {
  const GuardianManagementPage({super.key});

  @override
  ConsumerState<GuardianManagementPage> createState() =>
      _GuardianManagementPageState();
}

class _GuardianManagementPageState
    extends ConsumerState<GuardianManagementPage> with ToastMixin {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _addGuardian() {
    final digits = _phoneController.text.replaceAll('-', '');
    if (digits.length < 10) return;
    ref.read(connectionViewModelProvider.notifier).addConnection(
          guardianPhone: digits,
        );
    _phoneController.clear();
    showToast('보호자 등록 요청을 보냈습니다');
  }

  void _editNickname(Connection guardian) {
    final controller = TextEditingController(text: guardian.name);
    final colors = context.appColors;

    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('별칭 수정'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controller,
            placeholder: '별칭 입력',
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
              fontSize: 16,
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
              Navigator.of(dialogContext).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('확인'),
            onPressed: () {
              final newNickname = controller.text.trim();
              if (newNickname.isNotEmpty) {
                ref
                    .read(connectionViewModelProvider.notifier)
                    .updateConnectionName(
                      id: guardian.id,
                      name: newNickname,
                    );
                showToast('별칭이 변경되었습니다');
              }
              controller.dispose();
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
  }

  void _acceptConnection(Connection guardian) {
    // TODO: 백엔드 API 추가 후 연동 (PATCH /v1/connections/{id}/accept)
    showToast('${guardian.name.isNotEmpty ? guardian.name : guardian.phone} 연결을 수락했습니다');
  }

  Future<void> _rejectConnection(Connection guardian) async {
    final displayName =
        guardian.name.isNotEmpty ? guardian.name : guardian.phone;
    final confirmed = await showDestructiveConfirmDialog(
      context,
      title: '연결 거절',
      content: '$displayName의 연결 요청을 거절하시겠습니까?',
      destructiveLabel: '거절',
    );
    if (confirmed) {
      // TODO: 백엔드 API 추가 후 연동 (DELETE /v1/connections/{id})
      showToast('연결 요청을 거절했습니다');
    }
  }

  Future<void> _confirmRemoveGuardian(Connection guardian) async {
    final displayName =
        guardian.name.isNotEmpty ? guardian.name : guardian.phone;
    final confirmed = await showDestructiveConfirmDialog(
      context,
      title: '보호자 삭제',
      content: '$displayName을(를) 삭제하시겠습니까?',
    );
    if (confirmed) {
      // TODO: DELETE /v1/connections/{id} API 추가 후 연동
      showToast('보호자가 삭제되었습니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final connectionState = ref.watch(connectionViewModelProvider);
    final connectedGuardians =
        connectionState.connections.where((c) => c.isConnected).toList();
    final pendingGuardians =
        connectionState.connections.where((c) => c.isPending).toList();
    final totalCount = connectedGuardians.length + pendingGuardians.length;

    return CupertinoPageScaffold(
      backgroundColor: colors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: colors.surface,
        padding: const EdgeInsetsDirectional.only(start: 4, end: 8),
        border: Border(
          bottom: BorderSide(color: colors.border, width: 0.5),
        ),
        middle: Text(
          '보호자 관리',
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
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    children: [
                      AddConnectionCard(
                        controller: _phoneController,
                        connectionCount: totalCount,
                        onAdd: _addGuardian,
                      ),
                      const Gap(16),
                      if (pendingGuardians.isNotEmpty) ...[
                        ConnectionSectionHeader(
                          title: '대기 중인 연결',
                          count: pendingGuardians.length,
                        ),
                        const Gap(10),
                        ...pendingGuardians.map((guardian) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PendingConnectionCard(
                              connection: guardian,
                              onAccept: () => _acceptConnection(guardian),
                              onReject: () => _rejectConnection(guardian),
                            ),
                          );
                        }),
                        const Gap(8),
                      ],
                      if (connectedGuardians.isNotEmpty) ...[
                        ConnectionSectionHeader(
                          title: '연결된 보호자',
                          count: connectedGuardians.length,
                        ),
                        const Gap(10),
                        ...connectedGuardians.map((guardian) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _GuardianCard(
                              guardian: guardian,
                              onEditNickname: () => _editNickname(guardian),
                              onDelete: () =>
                                  _confirmRemoveGuardian(guardian),
                            ),
                          );
                        }),
                      ],
                      if (connectedGuardians.isEmpty &&
                          pendingGuardians.isEmpty)
                        const ConnectionEmptyState(
                          title: '아직 보호자가 없어요',
                          subtitle: '보호자를 등록하면 안부를 전달받을 수 있어요',
                        ),
                    ],
                  ),
          ),
          if (toastMessage != null)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 24,
              left: 0,
              right: 0,
              child: AppToast(message: toastMessage!),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 연결된 보호자 카드
// ─────────────────────────────────────────────
class _GuardianCard extends StatelessWidget {
  final Connection guardian;
  final VoidCallback onEditNickname;
  final VoidCallback onDelete;

  const _GuardianCard({
    required this.guardian,
    required this.onEditNickname,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Container(
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.person_fill,
              size: 24,
              color: colors.primary,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onEditNickname,
                  child: Row(
                    children: [
                      Text(
                        guardian.name,
                        style: textStyles.heading3.copyWith(fontSize: 16),
                      ),
                      const Gap(6),
                      Icon(
                        CupertinoIcons.pencil,
                        size: 18,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
                const Gap(2),
                Text(guardian.phone, style: textStyles.body2),
                const Gap(4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      '연결됨',
                      style: textStyles.caption.copyWith(
                        color: colors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onDelete,
            child: Icon(
              CupertinoIcons.xmark,
              size: 16,
              color: colors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
