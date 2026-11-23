import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:noji/core/constants/app_constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract final class OneSignalService {
  static String? _pendingUrl;
  static void Function(String url)? _urlHandler;
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    _initialized = true;

    OneSignal.initialize(AppConstants.oneSignalAppId);
    if (kDebugMode) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener(_handleClick);
  }

  static void _handleClick(OSNotificationClickEvent event) {
    final dynamic addData = event.notification.additionalData;
    final dynamic rawUrl = (addData is Map ? addData['url'] : null) ??
        event.notification.launchUrl ??
        event.result.url;

    if (rawUrl is String) {
      final String? sanitized = sanitizeUrl(rawUrl);
      if (sanitized != null) {
        if (_urlHandler != null) {
          _urlHandler!(sanitized);
        } else {
          _pendingUrl = sanitized;
        }
      }
    }
  }

  static String? sanitizeUrl(String? urlString) {
    if (urlString == null) return null;
    final String trimmed = urlString.trim();
    if (trimmed.isEmpty) return null;

    final Uri? uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) return null;
    if (uri.scheme.toLowerCase() != 'https') return null;

    final String host = uri.host.toLowerCase();
    if (host == 'nojiksa.com' || host.endsWith('.nojiksa.com')) {
      return uri.toString();
    }
    return null;
  }

  static String? get pendingUrl => _pendingUrl;

  static String? consumePendingUrl() {
    final String? url = _pendingUrl;
    _pendingUrl = null;
    return url;
  }

  static void registerUrlHandler(void Function(String url) handler) {
    _urlHandler = handler;
    final String? pending = consumePendingUrl();
    if (pending != null) {
      handler(pending);
    }
  }

  static void unregisterUrlHandler() {
    _urlHandler = null;
  }

  static bool get hasPermission => OneSignal.Notifications.permission;

  static Future<bool> requestPermission() async {
    return OneSignal.Notifications.requestPermission(true);
  }
}
