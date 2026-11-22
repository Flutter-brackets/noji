import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/privacy/presentation/screens/privacy_policy_screen.dart';

class OnboardingPrivacyLink extends StatelessWidget {
  const OnboardingPrivacyLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PrivacyPolicyScreen.open(context),
      child: const Text.rich(
        TextSpan(
          text: 'بمتابعتك فأنتِ توافقين على ',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B6B6B)),
          children: <InlineSpan>[
            TextSpan(
              text: 'سياسة الخصوصية',
              style: TextStyle(
                color: AppColors.warmGold,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.warmGold,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
