import 'package:flutter/material.dart';
import 'package:noji/features/splash/presentation/widgets/animated_gold_line.dart';
import 'package:noji/features/splash/presentation/widgets/animated_logo.dart';

class SplashCenter extends StatelessWidget {
  final Animation<double> logoOpacity;
  final Animation<double> logoScale;
  final Animation<double> logoSlide;
  final Animation<double> lineWidth;
  final double logoSize;

  const SplashCenter({
    super.key,
    required this.logoOpacity,
    required this.logoScale,
    required this.logoSlide,
    required this.lineWidth,
    required this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedLogo(
              opacity: logoOpacity,
              scale: logoScale,
              slide: logoSlide,
              size: logoSize,
            ),
            const SizedBox(height: 20),
            AnimatedGoldLine(
              animation: lineWidth,
              maxWidth: logoSize * (110.0 / 150.0),
            ),
          ],
        ),
      ),
    );
  }
}
