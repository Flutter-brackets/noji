import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:noji/features/splash/cubit/splash_cubit.dart';
import 'package:noji/features/splash/cubit/splash_state.dart';
import 'package:noji/features/splash/presentation/widgets/animated_gold_line.dart';
import 'package:noji/features/splash/presentation/widgets/animated_logo.dart';
import 'package:noji/features/webview/presentation/screens/main_webview_placeholder_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit()..initialize(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoSlide;
  late final Animation<double> _lineWidth;
  late final Animation<double> _splashFadeOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    const Interval logoCurve = Interval(0.0, 0.45, curve: Curves.easeOutCubic);
    _logoOpacity = CurvedAnimation(parent: _controller, curve: logoCurve);
    _logoScale = Tween<double>(begin: 0.88, end: 1.0).animate(_logoOpacity);
    _logoSlide = Tween<double>(begin: 12.0, end: 0.0).animate(_logoOpacity);

    _lineWidth = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 0.80, curve: Curves.easeInOutCubic),
    );

    _splashFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _navigate();
      }
    });

    _controller.forward();
  }

  void _navigate() {
    if (!mounted) return;
    final bool toHome =
        context.read<SplashCubit>().state is SplashNavigateToHome;
    final Widget dest = toHome
        ? const MainWebViewPlaceholderScreen()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, _, _) => dest,
        transitionsBuilder: (_, Animation<double> anim, _, Widget child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: FadeTransition(
        opacity: _splashFadeOut,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedLogo(
                  opacity: _logoOpacity,
                  scale: _logoScale,
                  slide: _logoSlide,
                ),
                const SizedBox(height: 20),
                AnimatedGoldLine(animation: _lineWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
