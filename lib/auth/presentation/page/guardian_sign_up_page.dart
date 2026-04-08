import 'package:duty_checker/auth/presentation/view_model/sign_up_view_model.dart';
import 'package:duty_checker/core/validators.dart';
import 'package:duty_checker/core/widget/sign_up_widgets.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _codeFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _phoneCompleted = false;
  bool _codeCompleted = false;
  bool _showVerification = false;
  bool _showPassword = false;
  bool _passwordCompleted = false;

  final _codeInputKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _codeFocusNode.dispose();
    _passwordFocusNode.dispose();
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

  Future<void> _onPhoneSend() async {
    final digits = _phoneController.text.replaceAll('-', '');
    if (!phoneRegex.hasMatch(digits)) {
      _showError('올바른 전화번호를 입력해주세요.\n예: 010-1234-5678');
      return;
    }
    try {
      await ref.read(signUpViewModelProvider.notifier).sendCode(phone: digits);
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
      return;
    }
    if (!mounted) return;
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

  Future<void> _onCodeSubmit() async {
    if (_codeController.text.length < 6) return;
    final digits = _phoneController.text.replaceAll('-', '');
    try {
      await ref.read(signUpViewModelProvider.notifier).verifyCode(
            phone: digits,
            code: _codeController.text,
          );
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
      return;
    }
    if (!mounted) return;
    setState(() {
      _codeCompleted = true;
      _showPassword = true;
    });
    _passwordFocusNode.requestFocus();
    _scrollToBottom();
  }

  void _onPasswordSubmit() {
    final pw = _passwordController.text;
    final confirm = _passwordConfirmController.text;
    if (pw.length < 6 || pw != confirm) return;
    setState(() {
      _passwordCompleted = true;
    });
  }

  Future<void> _onRegister() async {
    final digits = _phoneController.text.replaceAll('-', '');
    final pw = _passwordController.text;
    try {
      await ref.read(signUpViewModelProvider.notifier).register(
            phone: digits,
            password: pw,
            role: 'GUARDIAN',
          );
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
      return;
    }
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
        backgroundColor: context.appColors.background,
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: context.appColors.surface,
          padding: const EdgeInsetsDirectional.only(start: 4),
          border: Border(
            bottom: BorderSide(color: context.appColors.border, width: 0.5),
          ),
          middle: Text(
            '보호자 등록',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: context.appColors.textPrimary,
            ),
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.pop();
            },
            child: Icon(
              CupertinoIcons.chevron_left,
              color: context.appColors.textPrimary,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: context.appColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
                      child: Column(
                        children: [
                          StepItem(
                            isCompleted: _phoneCompleted,
                            isLast: !_showVerification && !_showPassword,
                            title: '전화번호 입력',
                            description: '보호자 본인의 전화번호를 입력해주세요',
                            content: PhoneStepContent(
                              controller: _phoneController,
                              isCompleted: _codeCompleted,
                              codeSent: _phoneCompleted,
                              onSend: _onPhoneSend,
                              onResend: () {
                                final digits = _phoneController.text.replaceAll('-', '');
                                ref.read(signUpViewModelProvider.notifier).sendCode(phone: digits);
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
                                isLast: !_showPassword,
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
                                isLast: true,
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
                  onTap: _onRegister,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
