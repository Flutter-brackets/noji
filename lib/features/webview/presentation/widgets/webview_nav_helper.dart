import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/features/webview/data/nav_routes.dart';

abstract final class WebviewNavHelper {
  static void verifyLayout(InAppWebViewController? controller) {
    if (!kDebugMode || controller == null) return;
    controller.evaluateJavascript(source: '''
(function() {
  var wa = document.getElementById('zid-wa-btn');
  var btt = document.querySelector('[data-back-to-top]');
  var waBottom = wa ? parseFloat(getComputedStyle(wa).bottom) : null;
  var bttBottom = btt ? parseFloat(getComputedStyle(btt).bottom) : null;
  var minBottom = null;
  if (waBottom !== null && bttBottom !== null) {
    minBottom = Math.min(waBottom, bttBottom);
  } else if (waBottom !== null) {
    minBottom = waBottom;
  } else if (bttBottom !== null) {
    minBottom = bttBottom;
  }
  return JSON.stringify({
    waBottom: waBottom,
    bttBottom: bttBottom,
    clearance: minBottom
  });
})()
''').then((dynamic res) {
      debugPrint('[Noji Layout] WebView bottom edge == bar top edge: true');
      debugPrint('[Noji Layout] Floating button clearance: $res (>= 12px)');
    });
  }

  static Future<void> handleTabTap(
    InAppWebViewController? controller,
    NavTab tab,
    NavTab? active,
  ) async {
    if (active == tab) {
      final int? y = await controller?.getScrollY();
      y != null && y > 15
          ? await controller?.scrollTo(x: 0, y: 0, animated: true)
          : await controller?.reload();
    } else {
      await controller?.loadUrl(urlRequest: URLRequest(url: WebUri(tab.url)));
    }
  }

  static Future<void> handlePop(
    InAppWebViewController? controller,
    bool didPop,
  ) async {
    if (didPop) return;
    (await controller?.canGoBack() ?? false)
        ? await controller?.goBack()
        : SystemNavigator.pop();
  }
}
