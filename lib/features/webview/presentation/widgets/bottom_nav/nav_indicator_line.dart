import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';

class NavIndicatorLine extends StatelessWidget {
  const NavIndicatorLine({
    required this.isActive,
    this.color = AppColors.warmGold,
    super.key,
  });

  final bool isActive;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      height: 2,
      width: isActive ? 22 : 0,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(1),
        boxShadow: isActive
            ? const <BoxShadow>[
                BoxShadow(
                  color: AppColors.mutedGold,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ]
            : null,
      ),
    );
  }
}
