import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/core/fcm/fcm_service.dart';
import 'package:duty_checker/core/network/dio_provider.dart';
import 'package:duty_checker/core/network/token_storage.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _tryAutoLogin();
    });
  }

  Future<void> _tryAutoLogin() async {
    final tokenStorage = ref.read(tokenStorageProvider);

    if (!tokenStorage.hasToken) {
      if (mounted) context.go('/login');
      return;
    }

    final refreshToken = tokenStorage.refreshToken;
    if (refreshToken == null) {
      await tokenStorage.clear();
      if (mounted) context.go('/login');
      return;
    }

    try {
      final refreshUseCase = ref.read(refreshTokenUseCaseProvider);
      final newToken = await refreshUseCase(refreshToken: refreshToken);
      await tokenStorage.saveTokens(
        accessToken: newToken.accessToken,
        refreshToken: newToken.refreshToken,
      );
      if (mounted) {
        ref.read(fcmServiceProvider).connectApi(ref.read(dioProvider));
        context.go(tokenStorage.isGuardian ? '/guardian/home' : '/user/home');
      }
    } catch (_) {
      await tokenStorage.clear();
      if (mounted) context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.appColors.background,
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/icon_morse_dark.svg',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 20),
              Text(
                '오늘안부',
                style: context.appTextStyles.heading1.copyWith(
                  color: context.appColors.primary,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
