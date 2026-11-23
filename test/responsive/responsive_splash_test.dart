import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/features/splash/cubit/splash_cubit.dart';
import 'package:noji/features/splash/presentation/widgets/splash_view.dart';
import 'responsive_test_helper.dart';

void main() {
  group('Responsive Splash Screen Tests', () {
    for (final Size size in ResponsiveTestHelper.testSizes) {
      for (final double scale in ResponsiveTestHelper.testTextScales) {
        testWidgets('Splash renders without overflow at $size scale $scale',
            (WidgetTester tester) async {
          await ResponsiveTestHelper.pumpWidgetWithSize(
            tester,
            child: BlocProvider<SplashCubit>(
              create: (_) => SplashCubit(),
              child: const SplashView(),
            ),
            size: size,
            textScale: scale,
          );
          await tester.pump(const Duration(milliseconds: 1600));
          expect(tester.takeException(), isNull);
        });
      }
    }

    testWidgets('Splash displays Powered by Hout signature',
        (WidgetTester tester) async {
      await ResponsiveTestHelper.pumpWidgetWithSize(
        tester,
        child: BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(),
          child: const SplashView(),
        ),
        size: const Size(393, 852),
        textScale: 1.0,
      );
      await tester.pump(const Duration(milliseconds: 1600));
      expect(find.text(AppConstants.poweredByHout), findsOneWidget);
    });
  });
}
