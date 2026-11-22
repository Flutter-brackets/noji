import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/core/services/cache_helper.dart';
import 'package:noji/features/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  void initialize() {
    final bool hasSeenOnboarding = CacheHelper.hasSeenOnboarding();
    if (hasSeenOnboarding) {
      emit(const SplashNavigateToHome());
    } else {
      emit(const SplashNavigateToOnboarding());
    }
  }
}
