import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:noji/features/webview/data/dom/dom_cleaner_script.dart';
import 'package:noji/features/webview/data/webview_settings.dart';

abstract final class WebviewPrewarmer {
  static final InAppWebViewKeepAlive keepAlive = InAppWebViewKeepAlive();
  static HeadlessInAppWebView? _headless;
  static bool _hasDisposed = false;

  static InAppWebViewKeepAlive get activeKeepAlive => keepAlive;

  static Future<void> prewarm() async {
    if (kIsWeb ||
        ![TargetPlatform.android, TargetPlatform.iOS]
            .contains(defaultTargetPlatform)) {
      return;
    }
    try {
      _headless = HeadlessInAppWebView(
        keepAlive: keepAlive,
        initialUrlRequest: URLRequest(
          url: WebUri(AppConstants.baseUrl),
          cachePolicy: URLRequestCachePolicy.USE_PROTOCOL_CACHE_POLICY,
        ),
        initialSettings: WebviewSettings.defaultSettings,
        initialUserScripts: DomCleanerScript.userScripts,
        onLoadStop: (_, WebUri? url) {
          if (kDebugMode) debugPrint('[Noji Prewarmer] Prewarm ready: $url');
        },
        onReceivedError: (_, _, _) {
          if (kDebugMode) debugPrint('[Noji Prewarmer] Prewarm failed silently');
        },
      );
      await _headless?.run();
    } catch (e) {
      if (kDebugMode) debugPrint('[Noji Prewarmer] Prewarm error: $e');
    }
  }

  static void disposeHeadless() {
    if (_hasDisposed) return;
    _hasDisposed = true;
    try {
      _headless?.dispose();
    } catch (_) {}
    _headless = null;
  }
}
