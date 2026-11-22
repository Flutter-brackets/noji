import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/webview/data/dom/dom_cleaner_script.dart';
import 'package:noji/features/webview/data/url_handler_service.dart';
import 'package:noji/features/webview/data/webview_prewarmer.dart';
import 'package:noji/features/webview/data/webview_settings.dart';
import 'package:noji/features/webview/data/webview_timing.dart';

class WebviewBrowserPane extends StatefulWidget {
  const WebviewBrowserPane({
    required this.onControllerCreated,
    required this.onLoadStart,
    required this.onLoadStop,
    required this.onUpdateVisitedHistory,
    required this.onReceivedError,
    required this.onDrawerChanged,
    super.key,
  });

  final ValueChanged<InAppWebViewController> onControllerCreated;
  final ValueChanged<String?> onLoadStart;
  final ValueChanged<String?> onLoadStop;
  final ValueChanged<String?> onUpdateVisitedHistory;
  final VoidCallback onReceivedError;
  final ValueChanged<bool> onDrawerChanged;

  @override
  State<WebviewBrowserPane> createState() => _WebviewBrowserPaneState();
}

class _WebviewBrowserPaneState extends State<WebviewBrowserPane> {
  InAppWebViewController? _controller;
  late final PullToRefreshController _pullController;
  int _lastProgressTimestamp = 0;

  @override
  void initState() {
    super.initState();
    _pullController = PullToRefreshController(
      settings: PullToRefreshSettings(color: AppColors.primaryEmerald),
      onRefresh: () async {
        defaultTargetPlatform == TargetPlatform.android
            ? _controller?.reload()
            : _controller?.loadUrl(
                urlRequest: URLRequest(url: await _controller?.getUrl()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      keepAlive: WebviewPrewarmer.activeKeepAlive,
      initialUrlRequest: URLRequest(
        url: WebUri(AppConstants.baseUrl),
        cachePolicy: URLRequestCachePolicy.USE_PROTOCOL_CACHE_POLICY,
      ),
      initialSettings: WebviewSettings.defaultSettings,
      initialUserScripts: DomCleanerScript.userScripts,
      pullToRefreshController: _pullController,
      onWebViewCreated: (InAppWebViewController c) {
        _controller = c;
        WebviewPrewarmer.disposeHeadless();
        c.addJavaScriptHandler(
          handlerName: 'navDrawer',
          callback: (List<dynamic> args) {
            final bool isOpen = args.isNotEmpty && args.first == true;
            widget.onDrawerChanged(isOpen);
          },
        );
        widget.onControllerCreated(c);
      },
      onLoadStart: (_, WebUri? u) {
        WebviewTiming.recordNavStart(u?.toString());
        widget.onLoadStart(u?.toString());
      },
      onLoadStop: (_, WebUri? u) {
        WebviewTiming.recordNavStop(u?.toString());
        _pullController.endRefreshing();
        widget.onLoadStop(u?.toString());
      },
      onProgressChanged: (_, int progress) {
        final int now = DateTime.now().millisecondsSinceEpoch;
        if (now - _lastProgressTimestamp >= 50 || progress == 100) {
          _lastProgressTimestamp = now;
        }
      },
      onUpdateVisitedHistory: (_, WebUri? u, _) =>
          widget.onUpdateVisitedHistory(u?.toString()),
      onReceivedError: (_, _, _) {
        _pullController.endRefreshing();
        widget.onReceivedError();
      },
      shouldOverrideUrlLoading: (_, NavigationAction action) async {
        final String? url = action.request.url?.toString();
        if (url == null) return NavigationActionPolicy.ALLOW;
        return await UrlHandlerService.handleUrl(url)
            ? NavigationActionPolicy.ALLOW
            : NavigationActionPolicy.CANCEL;
      },
    );
  }
}
