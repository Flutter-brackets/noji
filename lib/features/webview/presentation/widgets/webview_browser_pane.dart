import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/core/services/onesignal_service.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/webview/data/dom/dom_cleaner_script.dart';
import 'package:noji/features/webview/data/url_handler_service.dart';
import 'package:noji/features/webview/data/webview_prewarmer.dart';
import 'package:noji/features/webview/data/webview_settings.dart';
import 'package:noji/features/webview/data/webview_timing.dart';

class WebviewBrowserPane extends StatefulWidget {
  final ValueChanged<InAppWebViewController> onControllerCreated;
  final ValueChanged<String?> onLoadStart, onLoadStop, onUpdateVisitedHistory;
  final VoidCallback onReceivedError;
  final ValueChanged<bool> onDrawerChanged;

  const WebviewBrowserPane({
    super.key,
    required this.onControllerCreated,
    required this.onLoadStart,
    required this.onLoadStop,
    required this.onUpdateVisitedHistory,
    required this.onReceivedError,
    required this.onDrawerChanged,
  });

  @override
  State<WebviewBrowserPane> createState() => _WebviewBrowserPaneState();
}

class _WebviewBrowserPaneState extends State<WebviewBrowserPane> {
  InAppWebViewController? _controller;
  late final PullToRefreshController _pullController;

  @override
  void initState() {
    super.initState();
    _pullController = PullToRefreshController(
      settings: PullToRefreshSettings(color: AppColors.primaryEmerald),
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          _controller?.reload();
        } else {
          _controller?.loadUrl(
              urlRequest: URLRequest(url: await _controller?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String target =
        OneSignalService.consumePendingUrl() ?? AppConstants.baseUrl;
    final bool hasCold = target != AppConstants.baseUrl;

    return InAppWebView(
      keepAlive: hasCold ? null : WebviewPrewarmer.activeKeepAlive,
      initialUrlRequest: URLRequest(
        url: WebUri(target),
        cachePolicy: URLRequestCachePolicy.USE_PROTOCOL_CACHE_POLICY,
      ),
      initialSettings: WebviewSettings.getSettings(
        isTablet: MediaQuery.sizeOf(context).shortestSide >= 600.0,
      ),
      initialUserScripts: DomCleanerScript.userScripts,
      pullToRefreshController: _pullController,
      onWebViewCreated: (InAppWebViewController c) {
        _controller = c;
        WebviewPrewarmer.disposeHeadless();
        c.addJavaScriptHandler(
          handlerName: 'navDrawer',
          callback: (args) =>
              widget.onDrawerChanged(args.isNotEmpty && args.first == true),
        );
        widget.onControllerCreated(c);
      },
      onLoadStart: (_, u) {
        WebviewTiming.recordNavStart(u?.toString());
        widget.onLoadStart(u?.toString());
      },
      onLoadStop: (_, u) {
        WebviewTiming.recordNavStop(u?.toString());
        _pullController.endRefreshing();
        widget.onLoadStop(u?.toString());
      },
      onUpdateVisitedHistory: (_, u, _) {
        widget.onUpdateVisitedHistory(u?.toString());
      },
      onReceivedError: (_, _, _) {
        _pullController.endRefreshing();
        widget.onReceivedError();
      },
      shouldOverrideUrlLoading: (_, action) async {
        final String? url = action.request.url?.toString();
        if (url == null) return NavigationActionPolicy.ALLOW;
        return await UrlHandlerService.handleUrl(url)
            ? NavigationActionPolicy.ALLOW
            : NavigationActionPolicy.CANCEL;
      },
    );
  }
}
