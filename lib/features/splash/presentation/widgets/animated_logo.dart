import 'package:flutter/material.dart';
import 'package:noji/core/constants/app_constants.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<double> slide;

  const AnimatedLogo({
    super.key,
    required this.opacity,
    required this.scale,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacity,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.translate(
            offset: Offset(0, slide.value),
            child: Transform.scale(
              scale: scale.value,
              child: Image.asset(
                AppConstants.logoAssetPath,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
