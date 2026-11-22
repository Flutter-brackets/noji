import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';

class LinePageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const LinePageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, (int index) {
        final bool isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 4,
          width: isSelected ? 28 : 10,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.warmGold : const Color(0xFFD9D2C8),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
