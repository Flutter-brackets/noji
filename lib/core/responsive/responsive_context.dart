import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:noji/core/responsive/breakpoints.dart';

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  bool get isCompact => screenWidth < Breakpoints.compactMax;
  bool get isMedium =>
      screenWidth >= Breakpoints.compactMax &&
      screenWidth < Breakpoints.mediumMax;
  bool get isExpanded => screenWidth >= Breakpoints.mediumMax;

  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;
  bool get isShortScreen => screenHeight < 700.0;
  bool get isNarrow => screenWidth <= 340.0;

  WindowSizeClass get windowSizeClass {
    if (isExpanded) return WindowSizeClass.expanded;
    if (isMedium) return WindowSizeClass.medium;
    return WindowSizeClass.compact;
  }

  double get contentMaxWidth {
    if (isExpanded) return 840.0;
    if (isMedium) return 600.0;
    return double.infinity;
  }

  bool get hasHinge {
    final List<DisplayFeature> features = MediaQuery.displayFeaturesOf(this);
    return features.any(
      (DisplayFeature f) => f.type == DisplayFeatureType.hinge,
    );
  }
}
