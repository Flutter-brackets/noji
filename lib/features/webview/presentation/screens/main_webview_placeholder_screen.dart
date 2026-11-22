import 'package:flutter/material.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/core/theme/app_colors.dart';

class MainWebViewPlaceholderScreen extends StatelessWidget {
  const MainWebViewPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        title: const Text(
          AppConstants.appNameArabic,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppConstants.logoAssetPath,
                width: 110,
                height: 110,
              ),
              const SizedBox(height: 24),
              const Text(
                'مرحباً بك في نوجي',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryEmerald,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'وجهتك الأولى للعبايات الفاخرة.\nسيتم تفعيل متجر الويب قريباً.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
