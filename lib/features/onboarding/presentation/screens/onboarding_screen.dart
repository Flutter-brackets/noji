import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/responsive/responsive_context.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_bottom_bar.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_slide.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final OnboardingCubit cubit = context.read<OnboardingCubit>();
    final double topPad = MediaQuery.paddingOf(context).top;
    final double bottomPad = MediaQuery.paddingOf(context).bottom;
    final bool isTwoCol = context.isLandscape || !context.isCompact;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: cubit.pageController,
            itemCount: OnboardingItem.items.length,
            onPageChanged: cubit.onPageChanged,
            itemBuilder: (_, int i) => OnboardingSlide(
              item: OnboardingItem.items[i],
              index: i,
              pageController: cubit.pageController,
            ),
          ),
          Positioned(
            top: topPad + 14,
            left: 20,
            child: TextButton(
              onPressed: () => cubit.complete(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'تخطي',
                style: TextStyle(
                  color: Color(0xB3FFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (!isTwoCol)
            Positioned(
              left: 24,
              right: 24,
              bottom: math.max(bottomPad, 10.0),
              child: const OnboardingBottomBar(),
            ),
        ],
      ),
    );
  }
}
