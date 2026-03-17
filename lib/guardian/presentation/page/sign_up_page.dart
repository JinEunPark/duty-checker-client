import 'package:flutter/cupertino.dart';

class SignUpPage extends StatelessWidget {
  final String mode; // 'self' or 'guardian'

  const SignUpPage({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Text(mode == 'self' ? '당사자 회원가입' : '보호자 회원가입'),
        ),
      ),
    );
  }
}
