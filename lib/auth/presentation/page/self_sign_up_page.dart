import 'package:duty_checker/auth/presentation/view_model/sign_up_view_model.dart';
import 'package:duty_checker/core/widget/sign_up_widgets.dart';
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
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _guardianController = TextEditingController();

  final _codeFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _guardianFocusNode = FocusNode();

  bool _phoneCompleted = false;
  bool _codeCompleted = false;
  bool _showVerification = false;
  bool _showPassword = false;
  bool _passwordCompleted = false;
  bool _showGuardian = false;
  bool _isComplete = false;

  final List<String> _guardians = [];

  final _codeInputKey = GlobalKey();
  final _lastGuardianKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _guardianController.dispose();
    _codeFocusNode.dispose();
    _passwordFocusNode.dispose();
    _guardianFocusNode.dispose();
    super.dispose();
  }

  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first
        .viewInsets.bottom;
    if (bottomInset > 100) {
      _scrollToBottom();
    }
  }

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

  void _onPhoneSend() {
    final digits = _phoneController.text.replaceAll('-', '');
    if (digits.length < 10) return;
    ref.read(signUpViewModelProvider.notifier).sendCode(phone: digits);
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

  Future<void> _onCodeSubmit() async {
    if (_codeController.text.length < 6) return;
    final digits = _phoneController.text.replaceAll('-', '');
    await ref.read(signUpViewModelProvider.notifier).verifyCode(
          phone: digits,
          code: _codeController.text,
        );
    if (!mounted) return;
    final signUpState = ref.read(signUpViewModelProvider);
    if (signUpState.error != null) {
      _showError(signUpState.error!);
      return;
    }
    setState(() {
      _codeCompleted = true;
      _showPassword = true;
    });
    _passwordFocusNode.requestFocus();
    _scrollToBottom();
  }

  Future<void> _onPasswordSubmit() async {
    final pw = _passwordController.text;
    final confirm = _passwordConfirmController.text;
    if (pw.length < 6 || pw != confirm) return;
    final digits = _phoneController.text.replaceAll('-', '');
    await ref.read(signUpViewModelProvider.notifier).register(
          phone: digits,
          password: pw,
          role: 'SUBJECT',
        );
    if (!mounted) return;
    final signUpState = ref.read(signUpViewModelProvider);
    if (signUpState.error != null) {
      _showError(signUpState.error!);
      return;
    }
    setState(() {
      _passwordCompleted = true;
      _showGuardian = true;
    });
    _guardianFocusNode.requestFocus();
    _scrollToBottom();
  }

  void _addGuardian() {
    final digits = _guardianController.text.replaceAll('-', '');
    if (digits.length < 10 || _guardians.length >= 5) return;
    setState(() {
      _guardians.add(_guardianController.text);
      _guardianController.clear();
    });
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

  void _removeGuardian(int index) {
    setState(() => _guardians.removeAt(index));
  }

  void _onComplete() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_guardians.isEmpty) {
      showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('보호자 미등록'),
          content: const Text(
              '보호자가 등록되지 않았습니다. \n 추후 보호자 관리 메뉴에서 \n 등록할 수 있습니다.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('돌아가기'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            CupertinoDialogAction(
              child: const Text('계속 진행'),
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _isComplete = true;
                });
              },
            ),
          ],
        ),
      );
      return;
    }
    setState(() => _isComplete = true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isComplete,
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
          middle: Text(
            _isComplete ? '설정 완료' : '당사자 등록',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          leading: _isComplete
              ? const SizedBox.shrink()
              : CupertinoButton(
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
          child: _isComplete ? _buildCompleteScreen() : _buildStepScreen(),
        ),
      ),
    );
  }

  Widget _buildCompleteScreen() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray900.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.checkmark,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(24),
                  const Text('설정이 완료되었습니다', style: AppTextStyles.display1),
                  const Gap(16),
                  Text(
                    '안부 확인 서비스를 시작합니다\n등록하신 보호자에게 알림이 전송됩니다',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body2.copyWith(height: 1.6),
                  ),
                  const Gap(40),
                  Container(
                    width: double.infinity,
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
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('본인 전화번호',
                                style: AppTextStyles.body2.copyWith(fontSize: 15)),
                            Text(_phoneController.text,
                                style: AppTextStyles.body1Medium
                                    .copyWith(fontSize: 15)),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          height: 1,
                          color: AppColors.divider,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('보호자',
                                style: AppTextStyles.body2.copyWith(fontSize: 15)),
                            Text('${_guardians.length}명',
                                style: AppTextStyles.body1Medium
                                    .copyWith(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: SignUpCompleteButton(
            enabled: true,
            label: '시작하기',
            onTap: () {
              final user = ref.read(signUpViewModelProvider).user;
              context.go(user != null && user.isGuardian
                  ? '/guardian/home'
                  : '/user/home');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStepScreen() {
    return Column(
      children: [
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
                    StepItem(
                      isCompleted: _phoneCompleted,
                      isLast: !_showVerification && !_showPassword &&
                          !_showGuardian,
                      title: '전화번호 입력',
                      description: '안부 확인을 위해 본인 전화번호가 필요합니다',
                      content: PhoneStepContent(
                        controller: _phoneController,
                        isCompleted: _codeCompleted,
                        codeSent: _phoneCompleted,
                        onSend: _onPhoneSend,
                        onResend: () {
                          final digits =
                              _phoneController.text.replaceAll('-', '');
                          ref
                              .read(signUpViewModelProvider.notifier)
                              .sendCode(phone: digits);
                        },
                      ),
                      statusMessage: _phoneCompleted
                          ? const StepStatusMessage(text: '인증번호가 전송되었습니다')
                          : null,
                    ),
                    if (_showVerification)
                      AnimatedStep(
                        child: StepItem(
                          isCompleted: _codeCompleted,
                          isLast: !_showPassword && !_showGuardian,
                          title: '인증번호 입력',
                          description:
                              '${_phoneController.text}로 전송된 인증번호를 입력해주세요',
                          content: CodeStepContent(
                            controller: _codeController,
                            focusNode: _codeFocusNode,
                            inputKey: _codeInputKey,
                            isCompleted: _codeCompleted,
                            onSubmit: _onCodeSubmit,
                            expiresAt: ref.watch(signUpViewModelProvider.select((s) => s.codeExpiresAt)),
                          ),
                          statusMessage: _codeCompleted
                              ? const StepStatusMessage(text: '인증이 완료되었습니다')
                              : null,
                        ),
                      ),
                    if (_showPassword)
                      AnimatedStep(
                        child: StepItem(
                          isCompleted: _passwordCompleted,
                          isLast: !_showGuardian,
                          title: '비밀번호 설정',
                          description: '로그인에 사용할 비밀번호를 설정해주세요',
                          content: PasswordStepContent(
                            controller: _passwordController,
                            confirmController: _passwordConfirmController,
                            focusNode: _passwordFocusNode,
                            isCompleted: _passwordCompleted,
                            onSubmit: _onPasswordSubmit,
                          ),
                          statusMessage: _passwordCompleted
                              ? const StepStatusMessage(text: '비밀번호가 설정되었습니다')
                              : null,
                        ),
                      ),
                    if (_showGuardian)
                      AnimatedStep(
                        child: StepItem(
                          isCompleted: false,
                          isLast: true,
                          title: '보호자 등록',
                          description: '안부 확인이 없을 경우 알림을 받을 보호자를 등록합니다',
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: SignUpCompleteButton(
            enabled: _passwordCompleted,
            onTap: _onComplete,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 스텝 4: 보호자 등록 (당사자 전용)
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
                  PhoneFormatter(),
                ],
              ),
            ),
            const Gap(10),
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
        Text(
          '최대 5명까지 등록 가능 · ${guardians.length}/5',
          style: AppTextStyles.caption,
        ),
        if (guardians.isNotEmpty) ...[
          const Gap(12),
          Column(
            children: guardians.asMap().entries.map((entry) {
              final isLast = entry.key == guardians.length - 1;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  key: isLast ? lastGuardianKey : null,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('보호자 ${entry.key + 1}',
                                style: AppTextStyles.label),
                            const Gap(2),
                            Text(entry.value,
                                style: AppTextStyles.body1Medium),
                          ],
                        ),
                      ),
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
