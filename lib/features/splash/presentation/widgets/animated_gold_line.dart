import 'package:flutter/material.dart';

class AnimatedGoldLine extends StatelessWidget {
  final Animation<double> animation;
  final double? maxWidth;

  const AnimatedGoldLine({
    super.key,
    required this.animation,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final double targetWidth = maxWidth ??
        ((MediaQuery.sizeOf(context).width * 0.38).clamp(130.0, 220.0) *
            (110.0 / 150.0));

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: animation.value * targetWidth,
          height: 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0x00D4A373),
                Color(0xFFD4A373),
                Color(0xFFD4A373),
                Color(0x00D4A373),
              ],
              stops: <double>[0.0, 0.2, 0.8, 1.0],
            ),
          ),
        );
      },
    );
  }
}
