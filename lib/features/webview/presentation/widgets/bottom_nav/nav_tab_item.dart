import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/nav_bar_style.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/nav_indicator_line.dart';

class NavTabItem extends StatelessWidget {
  const NavTabItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    this.style = NavBarStyle.current,
    super.key,
  });

  final NavTab tab;
  final bool isActive;
  final VoidCallback onTap;
  final NavBarStyle style;

  (IconData, IconData, String) get _tabMeta => switch (tab) {
        NavTab.home => (Icons.home_outlined, Icons.home_rounded, 'الرئيسية'),
        NavTab.categories =>
          (Icons.grid_view_outlined, Icons.grid_view_rounded, 'الأقسام'),
        NavTab.cart =>
          (Icons.shopping_bag_outlined, Icons.shopping_bag_rounded, 'السلة'),
        NavTab.account =>
          (Icons.person_outline_rounded, Icons.person_rounded, 'حسابي'),
      };

  @override
  Widget build(BuildContext context) {
    final (IconData outline, IconData filled, String label) = _tabMeta;
    final Color iconColor =
        isActive ? style.activeIconColor : style.inactiveColor;
    final Color labelColor =
        isActive ? style.activeLabelColor : style.inactiveColor;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            NavIndicatorLine(
              isActive: isActive,
              color: style.indicatorLineColor,
            ),
            const SizedBox(height: 2),
            Icon(isActive ? filled : outline, size: 23, color: iconColor),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: labelColor,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
