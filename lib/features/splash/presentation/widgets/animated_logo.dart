import 'package:flutter/material.dart';
import 'package:noji/core/constants/app_constants.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<double> slide;
  final double? size;

  const AnimatedLogo({
    super.key,
    required this.opacity,
    required this.scale,
    required this.slide,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final double logoSize =
        size ?? (MediaQuery.sizeOf(context).width * 0.38).clamp(130.0, 220.0);

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
                width: logoSize,
                height: logoSize,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
