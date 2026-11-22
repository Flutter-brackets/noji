import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/data/dom/dom_cleaner_css.dart';
import 'package:noji/features/webview/data/dom/dom_cleaner_script.dart';

void main() {
  group('DomCleaner Tests', () {
    test('DomCleanerCss contains announcement bar hiding and tap highlight',
        () {
      expect(DomCleanerCss.css, contains('--announcement-height: 0px'));
      expect(DomCleanerCss.css, contains('.announcement-bar'));
      expect(DomCleanerCss.css, contains('-webkit-tap-highlight-color'));
      expect(DomCleanerCss.css, contains('user-select: none'));
      expect(DomCleanerCss.css, contains('user-select: text'));
      expect(DomCleanerCss.css.contains('--noji-nav-h'), isFalse);
      expect(DomCleanerCss.css.contains('#zid-wa-btn'), isFalse);
      expect(DomCleanerCss.css.contains('[data-back-to-top]'), isFalse);
    });

    test('DomCleanerScript configuration is valid', () {
      expect(DomCleanerScript.startScript.injectionTime,
          equals(UserScriptInjectionTime.AT_DOCUMENT_START));
      expect(DomCleanerScript.endScript.injectionTime,
          equals(UserScriptInjectionTime.AT_DOCUMENT_END));
      expect(DomCleanerScript.userScripts.length, equals(2));
      expect(DomCleanerScript.startScript.source, contains('noji-cleaner-css'));
      expect(DomCleanerScript.endScript.source, contains('MutationObserver'));
      expect(DomCleanerScript.endScript.source, contains('navDrawer'));
    });
  });
}
