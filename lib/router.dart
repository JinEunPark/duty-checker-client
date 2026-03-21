import 'package:duty_checker/guardian/presentation/page/guardian_home_page.dart';
import 'package:duty_checker/guardian/presentation/page/landing_page.dart';
import 'package:duty_checker/guardian/presentation/page/guardian_sign_up_page.dart';
import 'package:duty_checker/self/presentation/page/self_sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/landing',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: '/landing',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/sign-up/:mode',
      builder: (context, state) {
        final mode = state.pathParameters['mode']!;
        if (mode == 'guardian') return const GuardianSignUpPage();
        return const SelfSignUpPage();
      },
    ),
    GoRoute(
      path: '/guardian/home',
      builder: (context, state) => const GuardianHomePage(),
    ),
  ],
);
