import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/services/cache_helper.dart';
import 'package:noji/features/onboarding/cubit/onboarding_state.dart';
import 'package:noji/features/onboarding/models/onboarding_item.dart';
import 'package:noji/features/webview/presentation/screens/main_webview_placeholder_screen.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController = PageController();

  OnboardingCubit() : super(const OnboardingState());

  void onPageChanged(int index) {
    final bool isLast = index == OnboardingItem.items.length - 1;
    emit(state.copyWith(currentIndex: index, isLastPage: isLast));
  }

  void next() {
    if (!state.isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> complete(BuildContext context) async {
    await CacheHelper.setOnboardingSeen(value: true);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, _, _) => const MainWebViewPlaceholderScreen(),
        transitionsBuilder: (_, Animation<double> anim, _, Widget child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
