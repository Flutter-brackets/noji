import 'package:flutter/material.dart';
import 'package:noji/core/constants/app_constants.dart';

class OnboardingSlideImage extends StatelessWidget {
  final String imagePath;
  final int index;
  final PageController pageController;
  final double height;

  const OnboardingSlideImage({
    super.key,
    required this.imagePath,
    required this.index,
    required this.pageController,
    required this.height,
  });

  Widget _buildFallback() {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFFFAF8F5), Color(0x1A0C4A3E)],
        ),
      ),
      child: Center(
        child: Opacity(
          opacity: 0.20,
          child: Image.asset(AppConstants.logoAssetPath, width: 90, height: 90),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext ctx, Widget? child) {
        double offset = 0.0;
        if (pageController.hasClients &&
            pageController.position.haveDimensions) {
          offset = pageController.page ?? 0.0;
        }
        final double diff = offset - index;
        final double shift = diff * 20.0;
        final double fade = (1.0 - (diff.abs() * 0.4)).clamp(0.0, 1.0);

        return Opacity(
          opacity: fade,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.translate(
                offset: Offset(shift, 0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _buildFallback(),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.transparent, Color(0x40000000)],
                    stops: <double>[0.6, 1.0],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
