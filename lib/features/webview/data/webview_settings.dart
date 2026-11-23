import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract final class WebviewSettings {
  static InAppWebViewSettings getSettings({bool isTablet = false}) =>
      InAppWebViewSettings(
        // Common
        cacheEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        incognito: false,
        supportZoom: false,
        javaScriptEnabled: true,
        thirdPartyCookiesEnabled: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        // Android
        cacheMode: CacheMode.LOAD_DEFAULT,
        hardwareAcceleration: true,
        useWideViewPort: true,
        loadWithOverviewMode: true,
        mixedContentMode: MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
        allowFileAccess: false,
        allowContentAccess: false,
        safeBrowsingEnabled: true,
        // iOS
        allowsInlineMediaPlayback: true,
        allowsBackForwardNavigationGestures: true,
        isFraudulentWebsiteWarningEnabled: true,
        // User Agent: do not force phone UA on tablets/iPads
        userAgent: isTablet
            ? null
            : 'Mozilla/5.0 (Linux; Android 14; Mobile) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36 '
                'NojiApp/1.0',
      );

  static InAppWebViewSettings get defaultSettings => getSettings();

  static InAppWebViewSettings get offlineSettings => InAppWebViewSettings(
        cacheEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        incognito: false,
        supportZoom: false,
        javaScriptEnabled: true,
        thirdPartyCookiesEnabled: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        cacheMode: CacheMode.LOAD_CACHE_ELSE_NETWORK,
        hardwareAcceleration: true,
        useWideViewPort: true,
        loadWithOverviewMode: true,
        mixedContentMode: MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
        allowFileAccess: false,
        allowContentAccess: false,
        safeBrowsingEnabled: true,
        allowsInlineMediaPlayback: true,
        allowsBackForwardNavigationGestures: true,
        isFraudulentWebsiteWarningEnabled: true,
      );
}
