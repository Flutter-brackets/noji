import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class OrientationManager {
  static void update(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    if (size.shortestSide < 600.0) {
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }
}
