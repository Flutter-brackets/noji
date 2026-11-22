import 'package:flutter/foundation.dart';

abstract final class WebviewTiming {
  static int appStartTime = 0;
  static int _navStartTime = 0;
  static bool _firstLoadRecorded = false;

  static void init() {
    appStartTime = DateTime.now().millisecondsSinceEpoch;
  }

  static void recordNavStart(String? url) {
    if (!kDebugMode) return;
    _navStartTime = DateTime.now().millisecondsSinceEpoch;
    debugPrint('[Noji Timing] Navigation started: $url');
  }

  static void recordNavStop(String? url) {
    if (!kDebugMode) return;
    final int now = DateTime.now().millisecondsSinceEpoch;
    if (!_firstLoadRecorded) {
      _firstLoadRecorded = true;
      final int totalTime = appStartTime > 0 ? (now - appStartTime) : 0;
      debugPrint('[Noji Timing] App start -> first onLoadStop: ${totalTime}ms');
    }
    if (_navStartTime > 0) {
      final int navDuration = now - _navStartTime;
      debugPrint('[Noji Timing] Navigation load time: ${navDuration}ms ($url)');
    }
  }
}
