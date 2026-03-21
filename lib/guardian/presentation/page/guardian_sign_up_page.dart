import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class GuardianSignUpPage extends ConsumerStatefulWidget {
  const GuardianSignUpPage({super.key});

  @override
  ConsumerState<GuardianSignUpPage> createState() => _GuardianSignUpPageState();
}

class _GuardianSignUpPageState extends ConsumerState<GuardianSignUpPage> {
  final _scrollController = ScrollController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _codeFocusNode = FocusNode();

  bool _phoneCompleted = false;
  bool _codeCompleted = false;
  bool _showVerification = false;

  final _codeInputKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  void _onPhoneSend() {
    final digits = _phoneController.text.replaceAll('-', '');
    if (digits.length < 10) return;
    setState(() {
      _phoneCompleted = true;
      _showVerification = true;
    });
    _codeFocusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _codeInputKey.currentContext;
      if (ctx == null || !_scrollController.hasClients) return;
      final renderObject = ctx.findRenderObject();
      if (renderObject == null) return;
      final viewport = RenderAbstractViewport.of(renderObject);
      final offset = viewport.getOffsetToReveal(renderObject, 0.1).offset;
      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onCodeSubmit() {
    if (_codeController.text.length < 6) return;
    setState(() {
      _codeCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.surface,
          padding: const EdgeInsetsDirectional.only(start: 4),
          border: const Border(
            bottom: BorderSide(color: AppColors.border, width: 0.5),
          ),
          middle: const Text(
            '보호자 등록',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.pop();
            },
            child: const Icon(
              CupertinoIcons.chevron_left,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 스텝 목록
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
                      child: Column(
                        children: [
                          // 스텝 1: 전화번호 입력
                          _StepItem(
                            isCompleted: _phoneCompleted,
                            isLast: !_showVerification,
                            title: '전화번호 입력',
                            description: '보호자 본인의 전화번호를 입력해주세요',
                            content: _PhoneStepContent(
                              controller: _phoneController,
                              isCompleted: _phoneCompleted,
                              onSend: _onPhoneSend,
                            ),
                            statusMessage: _phoneCompleted
                                ? const _StatusMessage(text: '인증번호가 전송되었습니다')
                                : null,
                          ),

                          // 스텝 2: 인증번호 입력 (애니메이션 등장)
                          if (_showVerification)
                            _AnimatedStep(
                              child: _StepItem(
                                isCompleted: _codeCompleted,
                                isLast: true,
                                title: '인증번호 입력',
                                description:
                                    '${_phoneController.text}로 전송된 인증번호를 입력해주세요',
                                content: _CodeStepContent(
                                  controller: _codeController,
                                  focusNode: _codeFocusNode,
                                  inputKey: _codeInputKey,
                                  isCompleted: _codeCompleted,
                                  onSubmit: _onCodeSubmit,
                                ),
                                statusMessage: _codeCompleted
                                    ? const _StatusMessage(text: '인증이 완료되었습니다')
                                    : null,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 완료 버튼 (키보드가 올라오면 함께 올라감)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: _CompleteButton(
                  enabled: _codeCompleted,
                  onTap: () => context.go('/guardian/home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 슬라이드 + 페이드 애니메이션 래퍼
// 새 스텝이 추가될 때 아래에서 위로 등장
// ─────────────────────────────────────────────
class _AnimatedStep extends StatefulWidget {
  final Widget child;
  const _AnimatedStep({required this.child});

  @override
  State<_AnimatedStep> createState() => _AnimatedStepState();
}

class _AnimatedStepState extends State<_AnimatedStep>
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
class _StepItem extends StatelessWidget {
  final bool isCompleted;
  final bool isLast;
  final String title;
  final String description;
  final Widget content;
  final Widget? statusMessage;

  const _StepItem({
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
          // 왼쪽: 원형 인디케이터 + 연결선
          Column(
            children: [
              _StepCircle(isCompleted: isCompleted),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: isCompleted ? AppColors.success : AppColors.gray200,
                  ),
                ),
            ],
          ),
          const Gap(16),

          // 오른쪽: 제목, 설명, 입력 폼
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading3),
                const Gap(6),
                Text(description, style: AppTextStyles.body2),
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
class _StepCircle extends StatelessWidget {
  final bool isCompleted;
  const _StepCircle({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? AppColors.success : AppColors.primary,
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
class _StatusMessage extends StatelessWidget {
  final String text;
  const _StatusMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(CupertinoIcons.checkmark_alt,
            color: AppColors.success, size: 16),
        const Gap(6),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.success,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 스텝 1: 전화번호 입력
// ─────────────────────────────────────────────
class _PhoneStepContent extends StatelessWidget {
  final TextEditingController controller;
  final bool isCompleted;
  final VoidCallback onSend;

  const _PhoneStepContent({
    required this.controller,
    required this.isCompleted,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      enabled: !isCompleted,
      keyboardType: TextInputType.phone,
      placeholder: '010-0000-0000',
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _PhoneFormatter(),
      ],
      suffix: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: isCompleted ? null : onSend,
          child: Text(
            '전송',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isCompleted ? AppColors.textDisabled : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 스텝 2: 인증번호 입력 (6자리 OTP)
// ─────────────────────────────────────────────
class _CodeStepContent extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey inputKey;
  final bool isCompleted;
  final VoidCallback onSubmit;

  const _CodeStepContent({
    required this.controller,
    required this.focusNode,
    required this.inputKey,
    required this.isCompleted,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      key: inputKey,
      controller: controller,
      focusNode: focusNode,
      enabled: !isCompleted,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      // 6자리 입력 완료 시 자동 제출
      onChanged: (value) {
        if (value.length == 6) onSubmit();
      },
    );
  }
}

// ─────────────────────────────────────────────
// 완료 버튼
// ─────────────────────────────────────────────
class _CompleteButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _CompleteButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primary : AppColors.gray200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            '완료',
            style: AppTextStyles.body1Medium.copyWith(
              color: enabled ? AppColors.surface : AppColors.gray400,
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
