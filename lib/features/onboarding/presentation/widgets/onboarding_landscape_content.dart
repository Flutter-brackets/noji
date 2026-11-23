import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/core/widgets/powered_by_hout.dart';
import 'package:noji/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/onboarding/presentation/widgets/line_page_indicator.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:noji/features/onboarding/presentation/widgets/onboarding_privacy_link.dart';

class OnboardingLandscapeContent extends StatelessWidget {
  final OnboardingItem item;
  final int index;

  const OnboardingLandscapeContent({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final OnboardingCubit cubit = context.read<OnboardingCubit>();
    final bool isLast = index == OnboardingItem.items.length - 1;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.overline,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warmGold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryEmerald,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 16),
                LinePageIndicator(
                  count: OnboardingItem.items.length,
                  currentIndex: index,
                ),
                const SizedBox(height: 12),
                if (isLast) ...<Widget>[
                  const OnboardingPrivacyLink(),
                  const SizedBox(height: 10),
                ],
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: OnboardingButton(
                    isLastPage: isLast,
                    onPressed: () =>
                        isLast ? cubit.complete(context) : cubit.next(),
                  ),
                ),
                const SizedBox(height: 14),
                const SizedBox(
                  width: 420,
                  child: Center(child: PoweredByHout()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
