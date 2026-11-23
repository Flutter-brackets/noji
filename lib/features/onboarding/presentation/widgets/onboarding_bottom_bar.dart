import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/widgets/powered_by_hout.dart';
import 'package:noji/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:noji/features/onboarding/cubit/onboarding_state.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/line_page_indicator.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_privacy_link.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingCubit cubit = context.read<OnboardingCubit>();

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (BuildContext ctx, OnboardingState state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LinePageIndicator(
              count: OnboardingItem.items.length,
              currentIndex: state.currentIndex,
            ),
            const SizedBox(height: 16),
            if (state.isLastPage) ...<Widget>[
              const OnboardingPrivacyLink(),
              const SizedBox(height: 14),
            ] else
              const SizedBox(height: 4),
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
            const SizedBox(height: 14),
            const PoweredByHout(),
          ],
        );
      },
    );
  }
}
