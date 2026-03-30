import 'package:duty_checker/firebase_options.dart';
import 'package:duty_checker/router.dart';
import 'package:duty_checker/shared/fcm_service.dart';
import 'package:duty_checker/shared/shared_preferences_provider.dart';
import 'package:duty_checker/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final fcmService = FcmService(FirebaseMessaging.instance);
  await fcmService.initialize();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        fcmServiceProvider.overrideWithValue(fcmService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routerConfig: router,
      title: 'Duty Checker',
      theme: appTheme,
    );
  }
}
