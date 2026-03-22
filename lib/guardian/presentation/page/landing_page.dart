import 'package:duty_checker/guardian/presentation/widget/mode_card_widget.dart';
import 'package:duty_checker/guardian/presentation/widget/next_button_widget.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  // 선택된 모드: null(미선택), 'user'(당사자), 'guardian'(보호자)
  String? _selectedMode;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),

              // 타이틀
              const Text(
                '어떤 역할로\n시작하실 건가요?',
                style: AppTextStyles.display1,
              ),
              const Gap(12),
              const Text(
                '매일 한 번, 소중한 사람의 안부를 확인해요',
                style: AppTextStyles.body2,
              ),
              const Spacer(flex: 2),

              // 당사자 모드 카드
              ModeCardWidget(
                title: '당사자',
                description: '매일 보내드리는 알림에\n응답해 내 상태를 전달해요',
                icon: CupertinoIcons.person_fill,
                isSelected: _selectedMode == 'user',
                onTap: () => setState(() => _selectedMode = 'user'),
              ),
              const Gap(16),

              // 보호자 모드 카드
              ModeCardWidget(
                title: '보호자',
                description: '당사자의 하루 응답을 확인하며\n안부를 챙겨요',
                icon: CupertinoIcons.person_2_fill,
                isSelected: _selectedMode == 'guardian',
                onTap: () => setState(() => _selectedMode = 'guardian'),
              ),

              const Spacer(flex: 3),

              // 다음 버튼
              NextButtonWidget(
                enabled: _selectedMode != null,
                onTap: () => context.push('/sign-up/$_selectedMode'),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
