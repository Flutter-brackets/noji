import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/nav_bar_style.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/nav_tab_item.dart';

class SolidBottomNavBar extends StatelessWidget {
  const SolidBottomNavBar({
    required this.activeTab,
    required this.onTabSelected,
    required this.isDrawerOpen,
    required this.bottomInset,
    this.style = NavBarStyle.current,
    super.key,
  });

  final NavTab? activeTab;
  final ValueChanged<NavTab> onTabSelected;
  final bool isDrawerOpen;
  final double bottomInset;
  final NavBarStyle style;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDrawerOpen,
      child: ClipRect(
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          heightFactor: isDrawerOpen ? 0.0 : 1.0,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            offset: isDrawerOpen ? const Offset(0, 1.0) : Offset.zero,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              opacity: isDrawerOpen ? 0.0 : 1.0,
              child: Container(
                color: AppColors.softCream,
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 8,
                  bottom: math.max(bottomInset, 8.0),
                ),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: style.backgroundColor,
                    borderRadius: BorderRadius.circular(style.borderRadius),
                    border: style.border,
                    boxShadow: style.shadows,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: NavTab.values
                        .map((NavTab tab) => NavTabItem(
                              tab: tab,
                              isActive: activeTab == tab,
                              onTap: () => onTabSelected(tab),
                              style: style,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
