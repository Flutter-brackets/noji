import 'package:flutter/material.dart';
import 'package:noji/core/responsive/responsive_context.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_slide_image.dart';

class OnboardingPortraitSlide extends StatelessWidget {
  final OnboardingItem item;
  final int index;
  final PageController pageController;

  const OnboardingPortraitSlide({
    super.key,
    required this.item,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final bool isShort = context.isShortScreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
            child: OnboardingSlideImage(
              imagePath: item.imagePath,
              index: index,
              pageController: pageController,
              height: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            28,
            isShort ? 12 : 20,
            28,
            isShort ? 140 : 160,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                item.overline,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.warmGold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: isShort ? 4 : 8),
              Text(
                item.title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: isShort ? 24 : 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryEmerald,
                  height: 1.25,
                ),
              ),
              SizedBox(height: isShort ? 6 : 10),
              Text(
                item.description,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: isShort ? 14 : 15,
                  height: isShort ? 1.45 : 1.65,
                  color: const Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
