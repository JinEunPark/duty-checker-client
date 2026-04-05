import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// ─────────────────────────────────────────────
// 모델
// ─────────────────────────────────────────────
class _Invitation {
  final String id;
  final String? userName;
  final String userPhone;
  final String createdAt;

  const _Invitation({
    required this.id,
    this.userName,
    required this.userPhone,
    required this.createdAt,
  });
}

class _ConnectedUser {
  final String id;
  final String name;
  String? nickname;
  final String phone;

  _ConnectedUser({
    required this.id,
    required this.name,
    this.nickname,
    required this.phone,
  });
}

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
  // TODO: 실제 데이터로 교체
  final List<_ConnectedUser> _connectedUsers = [
    _ConnectedUser(
      id: 'user-1',
      name: '김철수',
      nickname: '아버지',
      phone: '010-1234-5678',
    ),
  ];

  final List<_Invitation> _invitations = [
    _Invitation(
      id: 'inv-1',
      userName: '박영희',
      userPhone: '010-5555-1234',
      createdAt: '2026-03-22T11:00:00Z',
    ),
  ];

  String? _toastMessage;

  void _showToast(String message) {
    setState(() => _toastMessage = message);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _toastMessage = null);
    });
  }

  // ── 초대 수락 ──
  void _acceptInvitation(String invitationId) {
    final invitation = _invitations.firstWhere((i) => i.id == invitationId);
    _showNicknameSetupDialog(invitation);
  }

  void _showNicknameSetupDialog(_Invitation invitation) {
    final controller = TextEditingController();

    showCupertinoDialog<void>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('이 분을 어떻게 부를까요?'),
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              const Text(
                '나중에 언제든지 수정할 수 있어요',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const Gap(12),
              CupertinoTextField(
                controller: controller,
                placeholder: '예: 어머니, 아들, 이웃 김○○',
                autofocus: true,
                maxLength: 10,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                placeholderStyle: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  color: AppColors.textTertiary,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('건너뛰기'),
            onPressed: () {
              Navigator.of(ctx).pop();
              _doAccept(invitation, null);
              controller.dispose();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('저장'),
            onPressed: () {
              final nickname = controller.text.trim();
              Navigator.of(ctx).pop();
              _doAccept(
                invitation,
                nickname.isEmpty ? null : nickname,
              );
              controller.dispose();
            },
          ),
        ],
      ),
    );
  }

  void _doAccept(_Invitation invitation, String? nickname) {
    setState(() {
      _connectedUsers.add(
        _ConnectedUser(
          id: invitation.id,
          name: invitation.userName ?? '이용자',
          nickname: nickname,
          phone: invitation.userPhone,
        ),
      );
      _invitations.removeWhere((i) => i.id == invitation.id);
    });
    _showToast('초대를 수락했습니다');
  }

  // ── 초대 거절 ──
  void _rejectInvitation(String invitationId) {
    showCupertinoDialog<void>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('초대 거절'),
        content: const Text('이 연결 요청을 거절하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('거절'),
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _invitations.removeWhere((i) => i.id == invitationId);
              });
              _showToast('초대를 거절했습니다');
            },
          ),
        ],
      ),
    );
  }

  // ── 닉네임 편집 ──
  void _editNickname(_ConnectedUser user) {
    final controller = TextEditingController(text: user.nickname ?? '');

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
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            placeholderStyle: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
            decoration: BoxDecoration(
              color: AppColors.gray100,
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
                setState(() => user.nickname = newNickname);
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
    final hasContent =
        _connectedUsers.isNotEmpty || _invitations.isNotEmpty;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.surface,
        padding: const EdgeInsetsDirectional.only(start: 4, end: 8),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
        middle: const Text(
          '연결 관리',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.chevron_left,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: hasContent ? _buildContent() : _buildEmptyState(),
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

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        // ── 연결된 분 ──
        if (_connectedUsers.isNotEmpty) ...[
          _SectionHeader(
            title: '연결된 분',
            count: _connectedUsers.length,
          ),
          const Gap(10),
          ..._connectedUsers.map(
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

        // ── 대기 중인 초대 ──
        if (_invitations.isNotEmpty) ...[
          _SectionHeader(
            title: '대기 중인 초대',
            count: _invitations.length,
          ),
          const Gap(10),
          ..._invitations.map(
            (invitation) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InvitationCard(
                invitation: invitation,
                onAccept: () => _acceptInvitation(invitation.id),
                onReject: () => _rejectInvitation(invitation.id),
              ),
            ),
          ),
        ],

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
                color: AppColors.gray100,
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
              '아직 연결이 없어요',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            const Text(
              '당사자가 보호자로 등록하면\n이곳에서 연결을 수락할 수 있습니다',
              style: AppTextStyles.body2,
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
    return Text(
      '$title ($count)',
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 연결된 당사자 카드
// ─────────────────────────────────────────────
class _ConnectedUserCard extends StatelessWidget {
  final _ConnectedUser user;
  final VoidCallback onEditNickname;

  const _ConnectedUserCard({
    required this.user,
    required this.onEditNickname,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = user.nickname ?? user.name;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // 아바타
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                displayName.isNotEmpty ? displayName[0] : '?',
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
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
                  style: AppTextStyles.heading3,
                ),
                const Gap(2),
                Text(
                  user.phone,
                  style: AppTextStyles.body2,
                ),
              ],
            ),
          ),

          // 편집 버튼
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onEditNickname,
            child: const Icon(
              CupertinoIcons.pencil,
              size: 18,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 초대 카드
// ─────────────────────────────────────────────
class _InvitationCard extends StatelessWidget {
  final _Invitation invitation;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _InvitationCard({
    required this.invitation,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.5),
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
          // 연결 요청 라벨
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '연결 요청',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.warning,
              ),
            ),
          ),
          const Gap(12),

          // 전화번호
          Text(
            invitation.userPhone,
            style: AppTextStyles.heading2,
          ),
          const Gap(6),
          const Text(
            '이 번호에서 안부 보호자로 등록했습니다',
            style: AppTextStyles.caption,
          ),
          const Gap(16),

          // 수락 / 거절 버튼
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onAccept,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          size: 16,
                          color: AppColors.surface,
                        ),
                        Gap(6),
                        Text(
                          '수락',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: GestureDetector(
                  onTap: onReject,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.gray300,
                        width: 1.5,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.xmark,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        Gap(6),
                        Text(
                          '거절',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.gray900,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray900.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.checkmark_circle_fill,
              size: 16,
              color: AppColors.surface,
            ),
            const Gap(8),
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
