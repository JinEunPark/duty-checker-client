import 'dart:async';

import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/core/widget/sign_up_widgets.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

// ─────────────────────────────────────────────
// 섹션 헤더
// ─────────────────────────────────────────────
class ConnectionSectionHeader extends StatelessWidget {
  final String title;
  final int count;

  const ConnectionSectionHeader({
    super.key,
    required this.title,
    required this.count,
  });

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
// 대기 중 연결 카드 (수락/거절)
// ─────────────────────────────────────────────
class PendingConnectionCard extends StatelessWidget {
  final Connection connection;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final bool showActions;

  const PendingConnectionCard({
    super.key,
    required this.connection,
    this.onAccept,
    this.onReject,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final displayName =
        connection.name.isNotEmpty ? connection.name : connection.phone;

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
      child: Column(
        children: [
          Row(
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
                    Text(displayName, style: textStyles.heading3),
                    if (connection.name.isNotEmpty) ...[
                      const Gap(2),
                      Text(connection.phone, style: textStyles.body2),
                    ],
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
                          showActions ? '연결 대기 중' : '수락 대기 중',
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
          if (showActions) ...[
            const Gap(14),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: colors.gray100,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: onReject,
                    child: Text(
                      '거절',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: onAccept,
                    child: Text(
                      '수락',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.surface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 연결 추가 입력 카드
// ─────────────────────────────────────────────
class AddConnectionCard extends StatelessWidget {
  final TextEditingController controller;
  final int connectionCount;
  final VoidCallback onAdd;
  final String placeholder;

  static final _phoneFormatter = PhoneFormatter();

  const AddConnectionCard({
    super.key,
    required this.controller,
    required this.connectionCount,
    required this.onAdd,
    this.placeholder = '전화번호 입력',
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final isFull = connectionCount >= 5;

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
                  placeholder: placeholder,
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
                    _phoneFormatter,
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
            '최대 5명까지 등록 가능 · $connectionCount/5',
            style: textStyles.caption,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 빈 상태 화면
// ─────────────────────────────────────────────
class ConnectionEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const ConnectionEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
  });

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
          Text(title, style: textStyles.heading2),
          const Gap(8),
          Text(subtitle, style: textStyles.body2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 토스트 알림
// ─────────────────────────────────────────────
class AppToast extends StatelessWidget {
  final String message;
  final bool isError;
  const AppToast({super.key, required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final bgColor = isError ? colors.error : colors.gray900;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: bgColor.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError
                  ? CupertinoIcons.exclamationmark_circle_fill
                  : CupertinoIcons.checkmark_circle_fill,
              size: 16,
              color: colors.surface,
            ),
            const Gap(8),
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 토스트 상태 관리 Mixin
// ─────────────────────────────────────────────
mixin ToastMixin<T extends StatefulWidget> on State<T> {
  String? toastMessage;
  bool toastIsError = false;
  Timer? _toastTimer;

  void showToast(String message, {bool isError = false}) {
    _toastTimer?.cancel();
    setState(() {
      toastMessage = message;
      toastIsError = isError;
    });
    _toastTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => toastMessage = null);
    });
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }
}

// ─────────────────────────────────────────────
// 확인 다이얼로그 유틸
// ─────────────────────────────────────────────
Future<bool> showDestructiveConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  String destructiveLabel = '삭제',
}) async {
  final result = await showCupertinoDialog<bool>(
    context: context,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: const Text('취소'),
          onPressed: () => Navigator.of(ctx).pop(false),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text(destructiveLabel),
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
  return result ?? false;
}
