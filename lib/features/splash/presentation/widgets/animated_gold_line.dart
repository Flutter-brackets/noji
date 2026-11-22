import 'package:flutter/material.dart';

class AnimatedGoldLine extends StatelessWidget {
  final Animation<double> animation;

  const AnimatedGoldLine({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: animation.value * 110.0,
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
