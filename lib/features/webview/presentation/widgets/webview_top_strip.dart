import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';

class WebviewTopStrip extends StatelessWidget {
  const WebviewTopStrip({required this.topInset, super.key});

  final double topInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topInset + 6,
      color: AppColors.softCream,
    );
  }
}
