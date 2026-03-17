import 'package:dotted_border/dotted_border.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelfSignUpPage extends ConsumerStatefulWidget {
  const SelfSignUpPage({super.key});

  @override
  ConsumerState<SelfSignUpPage> createState() => _SelfSignUpPageState();
}

class _SelfSignUpPageState extends ConsumerState<SelfSignUpPage>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _guardianController = TextEditingController();

  // 각 스텝 필드의 포커스 노드
  final _codeFocusNode = FocusNode();
  final _guardianFocusNode = FocusNode();

  bool _phoneCompleted = false;
  bool _codeCompleted = false;
  bool _showVerification = false;
  bool _showGuardian = false;

  final List<String> _guardians = [];

  // 인증번호 input을 화면 중앙으로 스크롤하기 위한 키
  final _codeInputKey = GlobalKey();

  // 마지막으로 추가된 보호자 카드를 화면 중앙으로 스크롤하기 위한 키
  final _lastGuardianKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 키보드 변화 감지 등록
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _guardianController.dispose();
    _codeFocusNode.dispose();
    _guardianFocusNode.dispose();
    super.dispose();
  }

  // 키보드가 올라올 때 자동으로 스크롤
  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    if (bottomInset > 100) {
      _scrollToBottom();
    }
  }

  // 새 스텝이 추가된 후 스크롤을 아래로 이동
  // addPostFrameCallback: 위젯이 화면에 그려진 직후 실행
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // 전화번호 전송 → 인증번호 스텝 등장 후 포커스 이동
  void _onPhoneSend() {
    final digits = _phoneController.text.replaceAll('-', '');
    if (digits.length < 10) return;
    setState(() {
      _phoneCompleted = true;
      _showVerification = true;
    });
    // 포커스를 즉시 이동 → 키보드가 이미 열린 상태 유지
    _codeFocusNode.requestFocus();
    // ensureVisible은 이미 보이는 위젯은 스크롤 안 함
    // getOffsetToReveal로 강제로 지정 위치(상단 10%)로 스크롤
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

  // 인증번호 확인 → 보호자 등록 스텝 등장 후 포커스 이동
  void _onCodeSubmit() {
    if (_codeController.text.length < 6) return;
    setState(() {
      _codeCompleted = true;
      _showGuardian = true;
    });
    // 포커스를 즉시 이동 → 키보드가 이미 열린 상태 유지
    _guardianFocusNode.requestFocus();
    _scrollToBottom();
  }

  // 보호자 추가
  void _addGuardian() {
    final digits = _guardianController.text.replaceAll('-', '');
    if (digits.length < 10 || _guardians.length >= 5) return;
    setState(() {
      _guardians.add(_guardianController.text);
      _guardianController.clear();
    });
    // 추가된 카드가 보일 만큼만 스크롤 (하단 기준)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _lastGuardianKey.currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.8,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  // 보호자 삭제
  void _removeGuardian(int index) {
    setState(() => _guardians.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 뒤로가기 (스와이프 포함) 시 키보드 해제
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
          '당사자 등록',
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
                        // 스텝 1: 전화번호 입력 (최초 노출)
                        _StepItem(
                          isCompleted: _phoneCompleted,
                          isLast: !_showVerification && !_showGuardian,
                          title: '전화번호 입력',
                          description: '안부 확인을 위해 본인 전화번호가 필요합니다',
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
                              isLast: !_showGuardian,
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

                        // 스텝 3: 보호자 등록 (애니메이션 등장)
                        if (_showGuardian)
                          _AnimatedStep(
                            child: _StepItem(
                              isCompleted: false,
                              isLast: true,
                              title: '보호자 등록',
                              description:
                                  '안부 확인이 없을 경우 알림을 받을 보호자를 등록합니다',
                              content: _GuardianStepContent(
                                controller: _guardianController,
                                focusNode: _guardianFocusNode,
                                guardians: _guardians,
                                lastGuardianKey: _lastGuardianKey,
                                onAdd: _addGuardian,
                                onRemove: _removeGuardian,
                              ),
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
                enabled: _codeCompleted && _guardians.isNotEmpty,
                onTap: () {}, // TODO: 완료 처리
              ),
            ),
          ],
        ),
      ),
    ), // CupertinoPageScaffold
    ); // PopScope
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
                    color:
                        isCompleted ? AppColors.success : AppColors.gray200,
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
              color:
                  isCompleted ? AppColors.textDisabled : AppColors.primary,
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
// 스텝 3: 보호자 등록
// ─────────────────────────────────────────────
class _GuardianStepContent extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<String> guardians;
  final GlobalKey lastGuardianKey;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  const _GuardianStepContent({
    required this.controller,
    required this.focusNode,
    required this.guardians,
    required this.lastGuardianKey,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isFull = guardians.length >= 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 입력 + 추가 버튼
        Row(
          children: [
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                enabled: !isFull,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _PhoneFormatter(),
                ],
              ),
            ),
            const Gap(10),

            // + 버튼
            GestureDetector(
              onTap: isFull ? null : onAdd,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: isFull ? AppColors.gray200 : AppColors.gray300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  CupertinoIcons.add,
                  size: 22,
                  color: isFull ? AppColors.gray400 : AppColors.gray700,
                ),
              ),
            ),
          ],
        ),
        const Gap(8),

        // 카운트 안내
        Text(
          '최대 5명까지 등록 가능 · ${guardians.length}/5',
          style: AppTextStyles.caption,
        ),

        // 등록된 보호자 목록
        if (guardians.isNotEmpty) ...[
          const Gap(12),
          Column(
            children: guardians.asMap().entries.map((entry) {
              final isLast = entry.key == guardians.length - 1;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  // 마지막 카드에 키 연결 → 추가 시 화면 중앙으로 스크롤
                  key: isLast ? lastGuardianKey : null,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      // 보호자 번호 아이콘
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          CupertinoIcons.person_fill,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const Gap(12),

                      // 전화번호
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '보호자 ${entry.key + 1}',
                              style: AppTextStyles.label,
                            ),
                            const Gap(2),
                            Text(
                              entry.value,
                              style: AppTextStyles.body1Medium,
                            ),
                          ],
                        ),
                      ),

                      // 삭제 버튼
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => onRemove(entry.key),
                        child: const Icon(
                          CupertinoIcons.xmark,
                          size: 16,
                          color: AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
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
