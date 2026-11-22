import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_slide_image.dart';

class OnboardingSlide extends StatelessWidget {
  final OnboardingItem item;
  final int index;
  final PageController pageController;

  const OnboardingSlide({
    super.key,
    required this.item,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.sizeOf(context).height * 0.62;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
          child: SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: OnboardingSlideImage(
              imagePath: item.imagePath,
              index: index,
              pageController: pageController,
              height: imageHeight,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryEmerald,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.description,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: Color(0xFF6B6B6B),
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
