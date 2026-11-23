import 'dart:collection';
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/features/webview/data/dom/dom_cleaner_css.dart';

abstract final class DomCleanerScript {
  static final UserScript startScript = UserScript(
    source: '''
(function() {
  if (document.documentElement) {
    document.documentElement.classList.add('noji-app');
  }
  function inject() {
    if (document.getElementById('noji-cleaner-css')) return;
    var s = document.createElement('style');
    s.id = 'noji-cleaner-css';
    s.textContent = ${jsonEncode(DomCleanerCss.css)};
    (document.head || document.documentElement).appendChild(s);
  }
  inject();
  if (!document.head) {
    document.addEventListener('DOMContentLoaded', inject, { once: true });
  }
})();
''',
    injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
  );

  static final UserScript endScript = UserScript(
    source: '''
(function() {
  var bannerSel = ['.announcement-bar', '.marquee-mode', '[class*="announcement-bar"]'];
  function removeBanners() {
    for (var i = 0; i < bannerSel.length; i++) {
      var els = document.querySelectorAll(bannerSel[i]);
      for (var j = 0; j < els.length; j++) els[j].remove();
    }
  }
  removeBanners();

  function isDrawerActive() {
    try {
      var drawer = document.getElementById('mobile-menu-drawer') ||
                   document.querySelector('.mobile-menu-drawer');
      if (drawer) {
        var ds = window.getComputedStyle(drawer);
        if (ds.display !== 'none' && ds.visibility !== 'hidden' &&
            (drawer.classList.contains('is-active') ||
             drawer.classList.contains('open') ||
             drawer.classList.contains('active'))) {
          return true;
        }
      }
      var overlay = document.getElementById('mobile-menu-overlay') ||
                    document.querySelector('.mobile-menu-overlay');
      if (overlay) {
        var os = window.getComputedStyle(overlay);
        if (os.display !== 'none' && os.visibility !== 'hidden' &&
            (overlay.classList.contains('is-active') ||
             overlay.classList.contains('open') ||
             overlay.classList.contains('active'))) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }

  var lastDrawerState = null;
  function notifyDrawer() {
    removeBanners();
    var open = isDrawerActive();
    if (open !== lastDrawerState) {
      lastDrawerState = open;
      if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
        window.flutter_inappwebview.callHandler('navDrawer', open);
      }
    }
  }

  notifyDrawer();
  var timer = null;
  var observer = new MutationObserver(function() {
    if (timer) clearTimeout(timer);
    timer = setTimeout(notifyDrawer, 50);
  });

  if (document.documentElement) {
    observer.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['class', 'style', 'aria-hidden'],
      childList: true,
      subtree: true
    });
  }
})();
''',
    injectionTime: UserScriptInjectionTime.AT_DOCUMENT_END,
  );

  static UnmodifiableListView<UserScript> get userScripts =>
      UnmodifiableListView<UserScript>(<UserScript>[startScript, endScript]);
}
