import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final bool isLastPage;

  const OnboardingState({
    this.currentIndex = 0,
    this.isLastPage = false,
  });

  OnboardingState copyWith({
    int? currentIndex,
    bool? isLastPage,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => <Object?>[currentIndex, isLastPage];
}
