import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/cubit/webview_state.dart';
import 'package:noji/features/webview/presentation/widgets/initial_loading_view.dart';
import 'package:noji/features/webview/presentation/widgets/offline_view.dart';

class WebviewStatusOverlay extends StatelessWidget {
  const WebviewStatusOverlay({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebviewCubit, WebviewState>(
      buildWhen: (p, c) =>
          p.isOffline != c.isOffline || p.hasLoadedOnce != c.hasLoadedOnce,
      builder: (ctx, state) {
        if (state.isOffline) {
          return OfflineView(onRetry: onRetry);
        }
        return state.hasLoadedOnce
            ? const SizedBox.shrink()
            : const InitialLoadingView();
      },
    );
  }
}
