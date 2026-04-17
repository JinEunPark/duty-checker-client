import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/presentation/view_model/connection_view_model.dart';
import 'package:duty_checker/core/widget/connection_widgets.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class UserManagementPage extends ConsumerStatefulWidget {
  const UserManagementPage({super.key});

  @override
  ConsumerState<UserManagementPage> createState() =>
      _UserManagementPageState();
}

class _UserManagementPageState extends ConsumerState<UserManagementPage>
    with ToastMixin {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _addSubject() async {
    final digits = _phoneController.text.replaceAll('-', '');
    if (digits.length < 10) return;
    await ref.read(connectionViewModelProvider.notifier).addConnection(
          targetPhone: digits,
        );
    if (!mounted) return;
    final error = ref.read(connectionViewModelProvider).error;
    if (error != null) {
      showToast(error, isError: true);
    } else {
      _phoneController.clear();
      showToast('당사자 등록 요청을 보냈습니다');
    }
  }

  void _acceptConnection(Connection user) {
    ref.read(connectionViewModelProvider.notifier).acceptConnection(id: user.id);
    showToast('연결을 수락했습니다');
  }

  Future<void> _rejectConnection(Connection user) async {
    final confirmed = await showDestructiveConfirmDialog(
      context,
      title: '연결 거절',
      content: '${user.phone}의 연결 요청을 거절하시겠습니까?',
      destructiveLabel: '거절',
    );
    if (confirmed) {
      ref.read(connectionViewModelProvider.notifier).rejectConnection(id: user.id);
      showToast('연결 요청을 거절했습니다');
    }
  }

  Future<void> _confirmRemoveUser(Connection user) async {
    final displayName = user.name.isNotEmpty ? user.name : user.phone;
    final confirmed = await showDestructiveConfirmDialog(
      context,
      title: '연결 해제',
      content: '$displayName과(와)의 연결을 해제하시겠습니까?',
      destructiveLabel: '해제',
    );
    if (confirmed) {
      ref.read(connectionViewModelProvider.notifier).deleteConnection(id: user.id);
      showToast('연결이 해제되었습니다');
    }
  }

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
                showToast('호칭이 변경되었습니다');
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
    final totalCount = connectedUsers.length + pendingUsers.length;

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
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    children: [
                      AddConnectionCard(
                        controller: _phoneController,
                        connectionCount: totalCount,
                        onAdd: _addSubject,
                        placeholder: '당사자 전화번호 입력',
                      ),
                      const Gap(20),
                      if (connectedUsers.isNotEmpty) ...[
                        ConnectionSectionHeader(
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
                              onDelete: () => _confirmRemoveUser(user),
                            ),
                          ),
                        ),
                        const Gap(8),
                      ],
                      if (pendingUsers.isNotEmpty) ...[
                        ConnectionSectionHeader(
                          title: '대기 중인 연결',
                          count: pendingUsers.length,
                        ),
                        const Gap(10),
                        ...pendingUsers.map(
                          (user) {
                            final isMine =
                                user.requesterRole == UserRole.guardian;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: PendingConnectionCard(
                                connection: user,
                                showActions: !isMine,
                                onAccept: () => _acceptConnection(user),
                                onReject: () => _rejectConnection(user),
                              ),
                            );
                          },
                        ),
                      ],
                      if (connectedUsers.isEmpty && pendingUsers.isEmpty)
                        const ConnectionEmptyState(
                          title: '아직 연결된 당사자가 없어요',
                          subtitle: '전화번호를 입력하여 당사자를 등록해 보세요',
                        ),
                    ],
                  ),
          ),
          if (toastMessage != null)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 24,
              left: 0,
              right: 0,
              child: AppToast(message: toastMessage!, isError: toastIsError),
            ),
        ],
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
  final VoidCallback onDelete;

  const _ConnectedUserCard({
    required this.user,
    required this.onEditNickname,
    required this.onDelete,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName, style: textStyles.heading3),
                const Gap(2),
                Text(user.phone, style: textStyles.body2),
              ],
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onEditNickname,
            child: Icon(
              CupertinoIcons.pencil,
              size: 18,
              color: colors.primary,
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
