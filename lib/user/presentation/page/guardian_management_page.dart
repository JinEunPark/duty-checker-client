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

  // TODO: 실제 데이터로 교체
  final List<_GuardianData> _guardians = [
    _GuardianData(
      nickname: '엄마',
      phone: '010-1234-5678',
      status: _GuardianStatus.pending,
    ),
    _GuardianData(
      nickname: '아빠',
      phone: '010-9876-5432',
      status: _GuardianStatus.connected,
    ),
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _addGuardian() {
    final digits = _phoneController.text.replaceAll('-', '');
    if (digits.length < 10 || _guardians.length >= 3) return;
    setState(() {
      _guardians.add(
        _GuardianData(
          nickname: '보호자 ${_guardians.length + 1}',
          phone: _phoneController.text,
          status: _GuardianStatus.pending,
        ),
      );
      _phoneController.clear();
    });
  }

  void _editNickname(int index) {
    final controller = TextEditingController(
      text: _guardians[index].nickname,
    );

    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('별칭 수정'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: CupertinoTextField(
            controller: controller,
            placeholder: '별칭 입력',
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
              fontSize: 16,
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
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('확인'),
            onPressed: () {
              final newNickname = controller.text.trim();
              if (newNickname.isNotEmpty) {
                setState(() {
                  _guardians[index] = _guardians[index].copyWith(
                    nickname: newNickname,
                  );
                });
              }
              controller.dispose();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _confirmRemoveGuardian(int index) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('보호자 삭제'),
        content: Text(
          '${_guardians[index].nickname}을(를) 삭제하시겠습니까?',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('삭제'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _guardians.removeAt(index));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.surface,
        padding: const EdgeInsetsDirectional.only(start: 4, end: 8),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
        middle: const Text(
          '보호자 관리',
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
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            _AddGuardianCard(
              controller: _phoneController,
              guardianCount: _guardians.length,
              onAdd: _addGuardian,
            ),
            const Gap(16),
            if (_guardians.isEmpty)
              const _EmptyState()
            else
              ...List.generate(_guardians.length, (index) {
                final guardian = _guardians[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _GuardianCard(
                    guardian: guardian,
                    onEditNickname: () => _editNickname(index),
                    onDelete: () => _confirmRemoveGuardian(index),
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
// 보호자 데이터 모델 (임시)
// ─────────────────────────────────────────────
enum _GuardianStatus { connected, pending }

class _GuardianData {
  final String nickname;
  final String phone;
  final _GuardianStatus status;

  const _GuardianData({
    required this.nickname,
    required this.phone,
    required this.status,
  });

  _GuardianData copyWith({
    String? nickname,
    String? phone,
    _GuardianStatus? status,
  }) {
    return _GuardianData(
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      status: status ?? this.status,
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
    final isFull = guardianCount >= 3;

    return Container(
      padding: const EdgeInsets.all(20),
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
                  placeholderStyle: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: AppColors.textTertiary,
                  ),
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
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
                    color: isFull ? AppColors.gray200 : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    size: 22,
                    color: isFull ? AppColors.gray400 : AppColors.surface,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            '최대 3명까지 등록 가능 · $guardianCount/3',
            style: AppTextStyles.caption,
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
  final _GuardianData guardian;
  final VoidCallback onEditNickname;
  final VoidCallback onDelete;

  const _GuardianCard({
    required this.guardian,
    required this.onEditNickname,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = guardian.status == _GuardianStatus.connected;

    return Container(
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
          // 아바타
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.person_fill,
              size: 24,
              color: AppColors.primary,
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
                        guardian.nickname,
                        style: AppTextStyles.heading3.copyWith(fontSize: 16),
                      ),
                      const Gap(6),
                      const Icon(
                        CupertinoIcons.pencil,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                const Gap(2),
                Text(guardian.phone, style: AppTextStyles.body2),
                const Gap(4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isConnected
                            ? AppColors.success
                            : AppColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      isConnected ? '연결됨' : '연결 대기 중',
                      style: AppTextStyles.caption.copyWith(
                        color: isConnected
                            ? AppColors.success
                            : AppColors.warning,
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
            child: const Icon(
              CupertinoIcons.xmark,
              size: 16,
              color: AppColors.gray400,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.gray100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.person_2_fill,
              size: 32,
              color: AppColors.gray400,
            ),
          ),
          const Gap(20),
          const Text('아직 보호자가 없어요', style: AppTextStyles.heading2),
          const Gap(8),
          const Text(
            '보호자를 등록하면 안부를 전달받을 수 있어요',
            style: AppTextStyles.body2,
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
