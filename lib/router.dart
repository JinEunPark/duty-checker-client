import 'package:duty_checker/guardian/presentation/page/guardian_home_page.dart';
import 'package:duty_checker/guardian/presentation/page/landing_page.dart';
import 'package:duty_checker/guardian/presentation/page/guardian_sign_up_page.dart';
import 'package:duty_checker/guardian/presentation/page/user_management_page.dart';
import 'package:duty_checker/presentation/page/login_page.dart';
import 'package:duty_checker/user/presentation/page/self_sign_up_page.dart';
import 'package:duty_checker/user/presentation/page/guardian_management_page.dart';
import 'package:duty_checker/user/presentation/page/user_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
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
      path: '/login',
      builder: (context, state) => const LoginPage(),
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
    GoRoute(
      path: '/guardian/management',
      builder: (context, state) => const UserManagementPage(),
    ),
    GoRoute(
      path: '/user/home',
      builder: (context, state) => const UserHomePage(),
    ),
    GoRoute(
      path: '/user/guardian-management',
      builder: (context, state) => const GuardianManagementPage(),
    ),
  ],
);
