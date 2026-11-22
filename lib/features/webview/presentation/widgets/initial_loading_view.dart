import 'package:flutter/material.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/core/theme/app_colors.dart';

class InitialLoadingView extends StatelessWidget {
  const InitialLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.softCream,
      child: Center(
        child: Image.asset(
          AppConstants.logoAssetPath,
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
