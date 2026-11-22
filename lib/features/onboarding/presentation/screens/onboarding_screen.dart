import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:noji/features/onboarding/cubit/onboarding_state.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/line_page_indicator.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_button.dart';
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
    final double topPadding = MediaQuery.paddingOf(context).top;
    final double bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: cubit.pageController,
            itemCount: OnboardingItem.items.length,
            onPageChanged: cubit.onPageChanged,
            itemBuilder: (_, int index) => OnboardingSlide(
              item: OnboardingItem.items[index],
              index: index,
              pageController: cubit.pageController,
            ),
          ),
          Positioned(
            top: topPadding + 14,
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
          Positioned(
            left: 24,
            right: 24,
            bottom: bottomPadding + 20,
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (BuildContext ctx, OnboardingState state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LinePageIndicator(
                      count: OnboardingItem.items.length,
                      currentIndex: state.currentIndex,
                    ),
                    const SizedBox(height: 20),
                    OnboardingButton(
                      isLastPage: state.isLastPage,
                      onPressed: () {
                        if (state.isLastPage) {
                          cubit.complete(ctx);
                        } else {
                          cubit.next();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
