import 'package:flutter/material.dart';
import 'package:noji/core/responsive/responsive_context.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_landscape_slide.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_portrait_slide.dart';

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
    final bool isTwoCol = context.isLandscape || !context.isCompact;
    if (isTwoCol) {
      return OnboardingLandscapeSlide(
        item: item,
        index: index,
        pageController: pageController,
      );
    }
    return OnboardingPortraitSlide(
      item: item,
      index: index,
      pageController: pageController,
    );
  }
}
