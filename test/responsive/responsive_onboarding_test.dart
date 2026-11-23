import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'responsive_test_helper.dart';

void main() {
  group('Responsive Onboarding Slides Tests', () {
    for (int slideIdx = 0;
        slideIdx < OnboardingItem.items.length;
        slideIdx++) {
      for (final Size size in ResponsiveTestHelper.testSizes) {
        for (final double scale in ResponsiveTestHelper.testTextScales) {
          testWidgets(
              'Slide $slideIdx renders cleanly at $size with scale $scale',
              (WidgetTester tester) async {
            final PageController pageController = PageController();
            addTearDown(pageController.dispose);

            await ResponsiveTestHelper.pumpWidgetWithSize(
              tester,
              child: BlocProvider<OnboardingCubit>(
                create: (_) => OnboardingCubit(),
                child: OnboardingSlide(
                  item: OnboardingItem.items[slideIdx],
                  index: slideIdx,
                  pageController: pageController,
                ),
              ),
              size: size,
              textScale: scale,
            );
            await tester.pump();
            expect(tester.takeException(), isNull);
          });
        }
      }
    }

    testWidgets('Powered by Hout is present on all three onboarding slides',
        (WidgetTester tester) async {
      await ResponsiveTestHelper.pumpWidgetWithSize(
        tester,
        child: const OnboardingScreen(),
        size: const Size(393, 852),
        textScale: 1.0,
      );
      await tester.pumpAndSettle();

      // Slide 0
      expect(find.text(AppConstants.poweredByHout), findsOneWidget);

      // Slide 1
      await tester.tap(find.byType(OnboardingButton));
      await tester.pumpAndSettle();
      expect(find.text(AppConstants.poweredByHout), findsOneWidget);

      // Slide 2
      await tester.tap(find.byType(OnboardingButton));
      await tester.pumpAndSettle();
      expect(find.text(AppConstants.poweredByHout), findsOneWidget);
    });

    testWidgets(
        'Powered by Hout is present on landscape two-column onboarding slides',
        (WidgetTester tester) async {
      final PageController pageController = PageController();
      addTearDown(pageController.dispose);

      for (int i = 0; i < OnboardingItem.items.length; i++) {
        await ResponsiveTestHelper.pumpWidgetWithSize(
          tester,
          child: BlocProvider<OnboardingCubit>(
            create: (_) => OnboardingCubit(),
            child: OnboardingSlide(
              item: OnboardingItem.items[i],
              index: i,
              pageController: pageController,
            ),
          ),
          size: const Size(852, 393),
          textScale: 1.0,
        );
        await tester.pumpAndSettle();
        expect(find.text(AppConstants.poweredByHout), findsOneWidget);
      }
    });
  });
}
