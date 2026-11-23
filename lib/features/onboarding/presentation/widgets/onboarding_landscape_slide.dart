import 'package:flutter/material.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_landscape_content.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_slide_image.dart';

class OnboardingLandscapeSlide extends StatelessWidget {
  final OnboardingItem item;
  final int index;
  final PageController pageController;

  const OnboardingLandscapeSlide({
    super.key,
    required this.item,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(32)),
            child: OnboardingSlideImage(
              imagePath: item.imagePath,
              index: index,
              pageController: pageController,
              height: double.infinity,
            ),
          ),
        ),
        Expanded(
          child: OnboardingLandscapeContent(
            item: item,
            index: index,
          ),
        ),
      ],
    );
  }
}
