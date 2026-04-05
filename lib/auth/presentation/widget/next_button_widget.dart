import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';

class NextButtonWidget extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;

  const NextButtonWidget({
    super.key,
    required this.enabled,
    required this.onTap,
  });

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
            '다음',
            style: AppTextStyles.body1Medium.copyWith(
              color: enabled ? AppColors.surface : AppColors.gray400,
            ),
          ),
        ),
      ),
    );
  }
}
