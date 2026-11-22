import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';

class NavBarStyle {
  final Color backgroundColor;
  final Border? border;
  final List<BoxShadow> shadows;
  final double borderRadius;
  final Color activeIconColor;
  final Color activeLabelColor;
  final Color inactiveColor;
  final Color indicatorLineColor;

  const NavBarStyle({
    required this.backgroundColor,
    this.border,
    required this.shadows,
    required this.borderRadius,
    required this.activeIconColor,
    required this.activeLabelColor,
    required this.inactiveColor,
    required this.indicatorLineColor,
  });

  static const NavBarStyle current = softGreen;

  static const NavBarStyle softGreen = NavBarStyle(
    backgroundColor: Color(0xFF2F4F46),
    border: null,
    shadows: <BoxShadow>[
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 18,
        offset: Offset(0, 4),
      ),
    ],
    borderRadius: 26.0,
    activeIconColor: Color(0xFFE0BF98),
    activeLabelColor: Color(0xFFE0BF98),
    inactiveColor: Color(0x8CFAF8F5),
    indicatorLineColor: Color(0xFFE0BF98),
  );

  static const NavBarStyle cream = NavBarStyle(
    backgroundColor: Color(0xFFF1ECE4),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0xFFE4DCCF), width: 1.0),
    ),
    shadows: <BoxShadow>[
      BoxShadow(
        color: Color(0x12000000),
        blurRadius: 18,
        offset: Offset(0, 4),
      ),
    ],
    borderRadius: 26.0,
    activeIconColor: AppColors.primaryEmerald,
    activeLabelColor: AppColors.primaryEmerald,
    inactiveColor: Color(0xFF8D918E),
    indicatorLineColor: AppColors.warmGold,
  );

  static const NavBarStyle emerald = NavBarStyle(
    backgroundColor: Color(0xFF0C4A3E),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0x59D4A373), width: 1.0),
    ),
    shadows: <BoxShadow>[
      BoxShadow(
        color: Color(0x26000000),
        blurRadius: 18,
        offset: Offset(0, 4),
      ),
    ],
    borderRadius: 26.0,
    activeIconColor: AppColors.warmGold,
    activeLabelColor: AppColors.softCream,
    inactiveColor: Color(0xA6FAF8F5),
    indicatorLineColor: AppColors.warmGold,
  );
}
