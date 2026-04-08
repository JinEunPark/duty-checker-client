import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../theme.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => context.push('/setting'),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: context.appColors.background,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          'assets/icons/icon_setting.svg',
          width: 14,
          height: 14,
          colorFilter: ColorFilter.mode(
            context.appColors.gray600,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
