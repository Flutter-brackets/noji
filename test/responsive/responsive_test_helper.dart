import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract final class ResponsiveTestHelper {
  static const List<Size> testSizes = <Size>[
    Size(320, 568),
    Size(360, 640),
    Size(393, 852),
    Size(430, 932),
    Size(600, 960),
    Size(834, 1194),
    Size(1032, 1376),
    Size(852, 393),
    Size(1194, 834),
    Size(1280, 800),
  ];

  static const List<double> testTextScales = <double>[1.0, 1.3];

  static Future<void> pumpWidgetWithSize(
    WidgetTester tester, {
    required Widget child,
    required Size size,
    required double textScale,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(
            size: size,
            textScaler: TextScaler.linear(textScale),
            padding: const EdgeInsets.only(top: 24, bottom: 20),
            viewPadding: const EdgeInsets.only(top: 24, bottom: 20),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Material(child: child),
          ),
        ),
      ),
    );
  }
}
