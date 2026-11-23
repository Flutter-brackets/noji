import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/widgets/webview_browser_pane.dart';
import 'package:noji/features/webview/presentation/widgets/webview_status_overlay.dart';

class WebviewStackPane extends StatelessWidget {
  final WebviewCubit cubit;
  final ValueChanged<InAppWebViewController> onControllerCreated;
  final ValueChanged<String?> onLoadStop;
  final VoidCallback onRetry;

  const WebviewStackPane({
    super.key,
    required this.cubit,
    required this.onControllerCreated,
    required this.onLoadStop,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RepaintBoundary(
          child: WebviewBrowserPane(
            onControllerCreated: onControllerCreated,
            onLoadStart: cubit.onLoadStart,
            onLoadStop: onLoadStop,
            onUpdateVisitedHistory: cubit.updateUrl,
            onReceivedError: () => cubit.setOffline(true),
            onDrawerChanged: cubit.setDrawerOpen,
          ),
        ),
        WebviewStatusOverlay(onRetry: onRetry),
      ],
    );
  }
}
