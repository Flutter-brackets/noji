import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/data/webview_settings.dart';

void main() {
  group('WebviewSettings Tests', () {
    test('defaultSettings has all required common, android, and iOS flags', () {
      final InAppWebViewSettings settings = WebviewSettings.defaultSettings;

      // Common flags
      expect(settings.cacheEnabled, isTrue);
      expect(settings.domStorageEnabled, isTrue);
      expect(settings.databaseEnabled, isTrue);
      expect(settings.incognito, isFalse);
      expect(settings.supportZoom, isFalse);
      expect(settings.javaScriptEnabled, isTrue);
      expect(settings.thirdPartyCookiesEnabled, isTrue);

      // Android flags
      expect(settings.cacheMode, equals(CacheMode.LOAD_DEFAULT));
      expect(settings.hardwareAcceleration, isTrue);
      expect(settings.useWideViewPort, isTrue);
      expect(settings.loadWithOverviewMode, isTrue);
      expect(settings.mixedContentMode,
          equals(MixedContentMode.MIXED_CONTENT_NEVER_ALLOW));
      expect(settings.allowFileAccess, isFalse);
      expect(settings.allowContentAccess, isFalse);
      expect(settings.safeBrowsingEnabled, isTrue);

      // iOS flags
      expect(settings.allowsInlineMediaPlayback, isTrue);
      expect(settings.allowsBackForwardNavigationGestures, isTrue);
      expect(settings.isFraudulentWebsiteWarningEnabled, isTrue);
    });

    test('offlineSettings switches cacheMode to LOAD_CACHE_ELSE_NETWORK', () {
      final InAppWebViewSettings offline = WebviewSettings.offlineSettings;
      expect(offline.cacheMode, equals(CacheMode.LOAD_CACHE_ELSE_NETWORK));
      expect(offline.cacheEnabled, isTrue);
      expect(offline.domStorageEnabled, isTrue);
    });
  });
}
