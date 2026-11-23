import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/solid_bottom_nav_bar.dart';
import 'responsive_test_helper.dart';

void main() {
  group('Responsive Bottom Navigation Bar Tests', () {
    for (final Size size in ResponsiveTestHelper.testSizes) {
      for (final double scale in ResponsiveTestHelper.testTextScales) {
        testWidgets('Bottom nav renders cleanly at $size with scale $scale',
            (WidgetTester tester) async {
          await ResponsiveTestHelper.pumpWidgetWithSize(
            tester,
            child: SolidBottomNavBar(
              activeTab: NavTab.home,
              onTabSelected: (_) {},
              isDrawerOpen: false,
              bottomInset: 20,
            ),
            size: size,
            textScale: scale,
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        });
      }
    }
  });
}
