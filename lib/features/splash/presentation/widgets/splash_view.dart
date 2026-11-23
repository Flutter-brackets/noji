import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/core/widgets/powered_by_hout.dart';
import 'package:noji/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:noji/features/splash/cubit/splash_cubit.dart';
import 'package:noji/features/splash/cubit/splash_state.dart';
import 'package:noji/features/splash/presentation/widgets/splash_center.dart';
import 'package:noji/features/webview/presentation/screens/main_webview_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity, _logoScale, _logoSlide;
  late final Animation<double> _lineWidth, _footerOpacity, _splashFadeOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    final AnimationController c = _controller;
    _logoOpacity = CurvedAnimation(
      parent: c,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    );
    _logoScale = Tween<double>(begin: 0.88, end: 1.0).animate(_logoOpacity);
    _logoSlide = Tween<double>(begin: 12.0, end: 0.0).animate(_logoOpacity);
    _lineWidth = CurvedAnimation(
      parent: c,
      curve: const Interval(0.40, 0.80, curve: Curves.easeInOutCubic),
    );
    _footerOpacity = CurvedAnimation(
      parent: c,
      curve: const Interval(0.55, 0.76, curve: Curves.easeOut),
    );
    _splashFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: c,
      curve: const Interval(0.80, 1.0, curve: Curves.easeInOut),
    ));
    _controller.addStatusListener((AnimationStatus s) {
      if (s == AnimationStatus.completed) _navigate();
    });
    _controller.forward();
  }

  void _navigate() {
    if (!mounted) return;
    final bool home = context.read<SplashCubit>().state is SplashNavigateToHome;
    final Widget page =
        home ? const MainWebViewScreen() : const OnboardingScreen();
    Navigator.of(context).pushReplacement(PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, anim, _, child) =>
          FadeTransition(opacity: anim, child: child),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double logoSize = (width * 0.38).clamp(130.0, 220.0);

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: FadeTransition(
        opacity: _splashFadeOut,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              SplashCenter(
                logoOpacity: _logoOpacity,
                logoScale: _logoScale,
                logoSlide: _logoSlide,
                lineWidth: _lineWidth,
                logoSize: logoSize,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24,
                child: FadeTransition(
                  opacity: _footerOpacity,
                  child: const Center(child: PoweredByHout()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
