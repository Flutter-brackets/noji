import 'package:equatable/equatable.dart';

class WebviewState extends Equatable {
  final bool isLoading;
  final bool isOffline;
  final bool canGoBack;
  final String? currentUrl;
  final bool hasLoadedOnce;
  final bool isDrawerOpen;

  const WebviewState({
    this.isLoading = true,
    this.isOffline = false,
    this.canGoBack = false,
    this.currentUrl,
    this.hasLoadedOnce = false,
    this.isDrawerOpen = false,
  });

  WebviewState copyWith({
    bool? isLoading,
    bool? isOffline,
    bool? canGoBack,
    String? currentUrl,
    bool? hasLoadedOnce,
    bool? isDrawerOpen,
  }) {
    return WebviewState(
      isLoading: isLoading ?? this.isLoading,
      isOffline: isOffline ?? this.isOffline,
      canGoBack: canGoBack ?? this.canGoBack,
      currentUrl: currentUrl ?? this.currentUrl,
      hasLoadedOnce: hasLoadedOnce ?? this.hasLoadedOnce,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoading,
    isOffline,
    canGoBack,
    currentUrl,
    hasLoadedOnce,
    isDrawerOpen,
  ];
}
