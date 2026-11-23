import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/core/responsive/breakpoints.dart';
import 'package:noji/core/responsive/responsive_context.dart';

void main() {
  testWidgets('ResponsiveContext flags calculate correctly across sizes',
      (WidgetTester tester) async {
    late BuildContext capturedContext;

    Future<void> pumpForSize(Size size) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: size),
          child: Builder(builder: (BuildContext ctx) {
            capturedContext = ctx;
            return const Placeholder();
          }),
        ),
      );
    }

    // Compact portrait
    await pumpForSize(const Size(393, 852));
    expect(capturedContext.isCompact, isTrue);
    expect(capturedContext.isMedium, isFalse);
    expect(capturedContext.isExpanded, isFalse);
    expect(capturedContext.isLandscape, isFalse);
    expect(capturedContext.windowSizeClass, WindowSizeClass.compact);

    // Medium tablet portrait
    await pumpForSize(const Size(700, 1000));
    expect(capturedContext.isCompact, isFalse);
    expect(capturedContext.isMedium, isTrue);
    expect(capturedContext.isExpanded, isFalse);
    expect(capturedContext.windowSizeClass, WindowSizeClass.medium);

    // Expanded desktop / tablet landscape
    await pumpForSize(const Size(1032, 1376));
    expect(capturedContext.isExpanded, isTrue);
    expect(capturedContext.windowSizeClass, WindowSizeClass.expanded);

    // Narrow & short screen checks
    await pumpForSize(const Size(320, 568));
    expect(capturedContext.isNarrow, isTrue);
    expect(capturedContext.isShortScreen, isTrue);
  });
}
