import 'dart:async';

import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

// ─────────────────────────────────────────────
// 슬라이드 + 페이드 애니메이션 래퍼
// ─────────────────────────────────────────────
class AnimatedStep extends StatefulWidget {
  final Widget child;
  const AnimatedStep({super.key, required this.child});

  @override
  State<AnimatedStep> createState() => _AnimatedStepState();
}

class _AnimatedStepState extends State<AnimatedStep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ─────────────────────────────────────────────
// 스텝 아이템 (인디케이터 + 콘텐츠)
// ─────────────────────────────────────────────
class StepItem extends StatelessWidget {
  final bool isCompleted;
  final bool isLast;
  final String title;
  final String description;
  final Widget content;
  final Widget? statusMessage;

  const StepItem({
    super.key,
    required this.isCompleted,
    required this.isLast,
    required this.title,
    required this.description,
    required this.content,
    this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              StepCircle(isCompleted: isCompleted),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: isCompleted ? context.appColors.success : context.appColors.gray200,
                  ),
                ),
            ],
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.appTextStyles.heading3),
                const Gap(6),
                Text(description, style: context.appTextStyles.body2),
                const Gap(16),
                content,
                if (statusMessage != null) ...[
                  const Gap(10),
                  statusMessage!,
                ],
                const Gap(28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 스텝 원형 인디케이터
// ─────────────────────────────────────────────
class StepCircle extends StatelessWidget {
  final bool isCompleted;
  const StepCircle({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? context.appColors.success : context.appColors.primary,
      ),
      child: isCompleted
          ? const Icon(
              CupertinoIcons.checkmark,
              color: CupertinoColors.white,
              size: 13,
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────
// 완료 상태 메시지
// ─────────────────────────────────────────────
class StepStatusMessage extends StatelessWidget {
  final String text;
  const StepStatusMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CupertinoIcons.checkmark_alt,
            color: context.appColors.success, size: 16),
        const Gap(6),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.appColors.success,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 전화번호 입력 + 재전송 카운트다운
// ─────────────────────────────────────────────
class PhoneStepContent extends StatefulWidget {
  final TextEditingController controller;
  final bool isCompleted;
  final bool codeSent;
  final VoidCallback onSend;
  final VoidCallback onResend;
  final int cooldownSeconds;

  const PhoneStepContent({
    super.key,
    required this.controller,
    required this.isCompleted,
    required this.codeSent,
    required this.onSend,
    required this.onResend,
    this.cooldownSeconds = 5,
  });

  @override
  State<PhoneStepContent> createState() => _PhoneStepContentState();
}

class _PhoneStepContentState extends State<PhoneStepContent> {
  int _remaining = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.codeSent) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant PhoneStepContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.codeSent && !oldWidget.codeSent) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _remaining = widget.cooldownSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remaining <= 1) {
        t.cancel();
        setState(() => _remaining = 0);
      } else {
        setState(() => _remaining--);
      }
    });
  }

  void _onResendTap() {
    widget.onResend();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCoolingDown = _remaining > 0;

    String buttonText;
    VoidCallback? onPressed;

    if (!widget.codeSent) {
      buttonText = '전송';
      onPressed = widget.onSend;
    } else if (isCoolingDown) {
      buttonText = '$_remaining초';
      onPressed = null;
    } else {
      buttonText = '재전송';
      onPressed = _onResendTap;
    }

    return CupertinoTextField(
      controller: widget.controller,
      enabled: !widget.codeSent,
      keyboardType: TextInputType.phone,
      placeholder: '010-0000-0000',
      placeholderStyle: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        color: context.appColors.textTertiary,
      ),
      style: TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        color: context.appColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: context.appColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneFormatter(),
      ],
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: onPressed != null ? context.appColors.primary : context.appColors.gray200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: onPressed != null ? context.appColors.surface : context.appColors.gray400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 인증번호 입력 (6자리 OTP) + 유효시간 표시
// ─────────────────────────────────────────────
class CodeStepContent extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey inputKey;
  final bool isCompleted;
  final VoidCallback onSubmit;
  final DateTime? expiresAt;

  const CodeStepContent({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.inputKey,
    required this.isCompleted,
    required this.onSubmit,
    this.expiresAt,
  });

  @override
  State<CodeStepContent> createState() => _CodeStepContentState();
}

class _CodeStepContentState extends State<CodeStepContent> {
  Timer? _timer;
  int _remainingSeconds = 0;
  late DateTime _fallbackExpiresAt;

  @override
  void initState() {
    super.initState();
    _fallbackExpiresAt = DateTime.now().add(const Duration(minutes: 5));
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  @override
  void didUpdateWidget(covariant CodeStepContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expiresAt != oldWidget.expiresAt) {
      if (widget.expiresAt != null && oldWidget.expiresAt == null) {
        _fallbackExpiresAt = widget.expiresAt!;
      }
      _updateRemaining();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRemaining() {
    if (widget.isCompleted) {
      _timer?.cancel();
      return;
    }
    final expiresAt = widget.expiresAt ?? _fallbackExpiresAt;
    final diff = expiresAt.difference(DateTime.now()).inSeconds;
    final newValue = diff > 0 ? diff : 0;
    if (newValue == _remainingSeconds) return;
    setState(() => _remainingSeconds = newValue);
    if (newValue == 0) _timer?.cancel();
  }

  String get _formattedTime {
    final min = _remainingSeconds ~/ 60;
    final sec = _remainingSeconds % 60;
    return '$min:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          key: widget.inputKey,
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: !widget.isCompleted && (widget.expiresAt == null || _remainingSeconds > 0),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: context.appColors.textPrimary,
            letterSpacing: 12,
          ),
          decoration: BoxDecoration(
            color: context.appColors.gray100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          onChanged: (value) {
            if (value.length == 6) widget.onSubmit();
          },
        ),
        if (!widget.isCompleted) ...[
          const Gap(8),
          Text(
            _remainingSeconds > 0
                ? '유효시간 $_formattedTime'
                : '인증번호가 만료되었습니다',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _remainingSeconds > 0
                  ? context.appColors.textTertiary
                  : context.appColors.error,
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 비밀번호 설정
// ─────────────────────────────────────────────
class PasswordStepContent extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController confirmController;
  final FocusNode focusNode;
  final bool isCompleted;
  final VoidCallback onSubmit;

  const PasswordStepContent({
    super.key,
    required this.controller,
    required this.confirmController,
    required this.focusNode,
    required this.isCompleted,
    required this.onSubmit,
  });

  @override
  State<PasswordStepContent> createState() => _PasswordStepContentState();
}

class _PasswordStepContentState extends State<PasswordStepContent> {
  final _confirmFocusNode = FocusNode();
  bool _showError = false;

  @override
  void dispose() {
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _tryAutoSubmit() {
    final pw = widget.controller.text;
    final confirm = widget.confirmController.text;
    if (pw.length < 6 || confirm.length < 6) return;
    if (pw != confirm) {
      setState(() => _showError = true);
      return;
    }
    setState(() => _showError = false);
    widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: !widget.isCompleted,
          obscureText: true,
          placeholder: '비밀번호 (6자 이상)',
          placeholderStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            color: context.appColors.textTertiary,
          ),
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            color: context.appColors.textPrimary,
          ),
          decoration: BoxDecoration(
            color: context.appColors.gray100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          onSubmitted: (_) => _confirmFocusNode.requestFocus(),
          onChanged: (_) {
            if (_showError) setState(() => _showError = false);
          },
        ),
        const Gap(10),
        CupertinoTextField(
          controller: widget.confirmController,
          focusNode: _confirmFocusNode,
          enabled: !widget.isCompleted,
          obscureText: true,
          placeholder: '비밀번호 확인',
          placeholderStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            color: context.appColors.textTertiary,
          ),
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            color: context.appColors.textPrimary,
          ),
          decoration: BoxDecoration(
            color: context.appColors.gray100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          onChanged: (_) {
            if (_showError) setState(() => _showError = false);
            _tryAutoSubmit();
          },
        ),
        if (_showError) ...[
          const Gap(8),
          Text(
            '비밀번호가 일치하지 않습니다',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.appColors.error,
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 완료 버튼
// ─────────────────────────────────────────────
class SignUpCompleteButton extends StatelessWidget {
  final bool enabled;
  final String label;
  final VoidCallback onTap;

  const SignUpCompleteButton({
    super.key,
    required this.enabled,
    required this.onTap,
    this.label = '완료',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: enabled ? context.appColors.primary : context.appColors.gray200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: context.appTextStyles.body1Medium.copyWith(
              color: enabled ? context.appColors.surface : context.appColors.gray400,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 전화번호 자동 포매터 (010-XXXX-XXXX)
// ─────────────────────────────────────────────
class PhoneFormatter extends TextInputFormatter {
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
