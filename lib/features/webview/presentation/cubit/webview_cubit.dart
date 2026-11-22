import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/features/webview/presentation/cubit/webview_state.dart';

class WebviewCubit extends Cubit<WebviewState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  InAppWebViewController? _controller;

  WebviewCubit({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(const WebviewState()) {
    _initConnectivity();
  }

  void attachController(InAppWebViewController? controller) {
    _controller = controller;
  }

  void _initConnectivity() {
    _subscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final bool offline =
          results.contains(ConnectivityResult.none) && results.length == 1;
      _handleConnectivityChange(offline);
    });
  }

  void _handleConnectivityChange(bool offline) {
    if (offline) {
      _controller?.setSettings(
        settings: InAppWebViewSettings(
          cacheMode: CacheMode.LOAD_CACHE_ELSE_NETWORK,
        ),
      );
    } else {
      _controller?.setSettings(
        settings: InAppWebViewSettings(
          cacheMode: CacheMode.LOAD_DEFAULT,
        ),
      );
      if (state.isOffline) {
        emit(state.copyWith(isOffline: false));
      }
    }
  }

  void onLoadStart(String? url) {
    emit(state.copyWith(
      isLoading: true,
      currentUrl: url,
      isOffline: false,
      isDrawerOpen: false,
    ));
  }

  void onLoadStop(String? url) {
    emit(state.copyWith(
      isLoading: false,
      currentUrl: url,
      hasLoadedOnce: true,
    ));
  }

  void setOffline(bool offline) {
    emit(state.copyWith(
      isOffline: offline,
      isLoading: false,
    ));
  }

  void updateCanGoBack(bool canGoBack) {
    emit(state.copyWith(canGoBack: canGoBack));
  }

  void updateUrl(String? url) {
    emit(state.copyWith(currentUrl: url));
  }

  void setDrawerOpen(bool isOpen) {
    if (state.isDrawerOpen != isOpen) {
      emit(state.copyWith(isDrawerOpen: isOpen));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
