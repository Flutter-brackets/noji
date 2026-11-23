import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/presentation/widgets/initial_loading_view.dart';
import 'package:noji/features/webview/presentation/widgets/offline_view.dart';
import 'responsive_test_helper.dart';

void main() {
  group('Responsive Offline and Loading Views Tests', () {
    for (final Size size in ResponsiveTestHelper.testSizes) {
      for (final double scale in ResponsiveTestHelper.testTextScales) {
        testWidgets('Offline view renders cleanly at $size with scale $scale',
            (WidgetTester tester) async {
          await ResponsiveTestHelper.pumpWidgetWithSize(
            tester,
            child: OfflineView(onRetry: () {}),
            size: size,
            textScale: scale,
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        });

        testWidgets(
            'Initial loading view renders cleanly at $size with scale $scale',
            (WidgetTester tester) async {
          await ResponsiveTestHelper.pumpWidgetWithSize(
            tester,
            child: const InitialLoadingView(),
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
