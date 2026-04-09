import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/presentation/view_model/connection_view_model.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// ─────────────────────────────────────────────
// 보호자 관리 페이지
// ─────────────────────────────────────────────
class GuardianManagementPage extends ConsumerStatefulWidget {
  const GuardianManagementPage({super.key});

  @override
  ConsumerState<GuardianManagementPage> createState() =>
      _GuardianManagementPageState();
}

class _GuardianManagementPageState
    extends ConsumerState<GuardianManagementPage> {
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
  }

  void _editNickname(Connection guardian) {
    final controller = TextEditingController(text: guardian.name);

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
              color: context.appColors.textPrimary,
            ),
            placeholderStyle: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              color: context.appColors.textTertiary,
            ),
            decoration: BoxDecoration(
              color: context.appColors.gray100,
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
              }
              controller.dispose();
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
  }

  void _confirmRemoveGuardian(Connection guardian) {
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('보호자 삭제'),
        content: Text('${guardian.name.isNotEmpty ? guardian.name : guardian.phone}을(를) 삭제하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('삭제'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // TODO: DELETE /v1/connections/{id} API 추가 후 연동
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
    final guardians = connectionState.connections;

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
      child: SafeArea(
        child: connectionState.isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                children: [
                  _AddGuardianCard(
                    controller: _phoneController,
                    guardianCount: guardians.length,
                    onAdd: _addGuardian,
                  ),
                  const Gap(16),
                  if (guardians.isEmpty)
                    const _EmptyState()
                  else
                    ...guardians.map((guardian) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _GuardianCard(
                          guardian: guardian,
                          onEditNickname: () => _editNickname(guardian),
                          onDelete: () => _confirmRemoveGuardian(guardian),
                        ),
                      );
                    }),
                ],
              ),
      ),
    );
  }
}


// ─────────────────────────────────────────────
// 보호자 추가 입력 카드
// ─────────────────────────────────────────────
class _AddGuardianCard extends StatelessWidget {
  final TextEditingController controller;
  final int guardianCount;
  final VoidCallback onAdd;

  const _AddGuardianCard({
    required this.controller,
    required this.guardianCount,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final isFull = guardianCount >= 3;

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: controller,
                  enabled: !isFull,
                  keyboardType: TextInputType.phone,
                  placeholder: '전화번호 입력',
                  placeholderStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: colors.textTertiary,
                  ),
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: colors.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    color: colors.gray100,
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
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: isFull ? null : onAdd,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: isFull ? colors.gray200 : colors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    size: 22,
                    color: isFull ? colors.gray400 : colors.surface,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            '최대 3명까지 등록 가능 · $guardianCount/3',
            style: textStyles.caption,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 보호자 개별 카드
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
    final isConnected = guardian.isConnected;

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
          // 아바타
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

          // 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 별칭 + 수정 버튼
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
                        color: isConnected
                            ? colors.success
                            : colors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      isConnected ? '연결됨' : '연결 대기 중',
                      style: textStyles.caption.copyWith(
                        color: isConnected
                            ? colors.success
                            : colors.warning,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 삭제 버튼
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

// ─────────────────────────────────────────────
// 빈 상태 화면
// ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colors.gray100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.person_2_fill,
              size: 32,
              color: colors.gray400,
            ),
          ),
          const Gap(20),
          Text('아직 보호자가 없어요', style: textStyles.heading2),
          const Gap(8),
          Text(
            '보호자를 등록하면 안부를 전달받을 수 있어요',
            style: textStyles.body2,
          ),
        ],
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
