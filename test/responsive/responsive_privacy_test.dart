import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/privacy/presentation/screens/privacy_policy_screen.dart';
import 'responsive_test_helper.dart';

void main() {
  group('Responsive Privacy Policy Tests', () {
    for (final Size size in ResponsiveTestHelper.testSizes) {
      for (final double scale in ResponsiveTestHelper.testTextScales) {
        testWidgets('Privacy screen renders cleanly at $size with scale $scale',
            (WidgetTester tester) async {
          await ResponsiveTestHelper.pumpWidgetWithSize(
            tester,
            child: const PrivacyPolicyScreen(),
            size: size,
            textScale: scale,
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        });
      }
    }
  });
}
