import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

abstract final class CacheHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static bool hasSeenOnboarding() {
    return _preferences?.getBool(AppConstants.onboardingCacheKey) ?? false;
  }

  static Future<bool> setOnboardingSeen({bool value = true}) async {
    final SharedPreferences? prefs = _preferences;
    if (prefs == null) return false;
    return prefs.setBool(AppConstants.onboardingCacheKey, value);
  }

  static int getNotificationPromptCount() {
    return _preferences?.getInt(AppConstants.notifPromptCountKey) ?? 0;
  }

  static Future<bool> setNotificationPromptCount(int count) async {
    final SharedPreferences? prefs = _preferences;
    if (prefs == null) return false;
    return prefs.setInt(AppConstants.notifPromptCountKey, count);
  }

  static int? getLastNotificationPromptTime() {
    return _preferences?.getInt(AppConstants.notifLastPromptTimeKey);
  }

  static Future<bool> setLastNotificationPromptTime(int epochMs) async {
    final SharedPreferences? prefs = _preferences;
    if (prefs == null) return false;
    return prefs.setInt(AppConstants.notifLastPromptTimeKey, epochMs);
  }

  static bool shouldPromptNotification({DateTime? now}) {
    final int count = getNotificationPromptCount();
    if (count >= 3) return false;

    final int? lastMs = getLastNotificationPromptTime();
    if (lastMs != null) {
      final int currentMs = (now ?? DateTime.now()).millisecondsSinceEpoch;
      const int threeDaysMs = 3 * 24 * 60 * 60 * 1000;
      if (currentMs - lastMs < threeDaysMs) return false;
    }
    return true;
  }

  static Future<void> recordNotificationPrompt({DateTime? now}) async {
    await setNotificationPromptCount(getNotificationPromptCount() + 1);
    final int currentMs = (now ?? DateTime.now()).millisecondsSinceEpoch;
    await setLastNotificationPromptTime(currentMs);
  }

  static Future<bool> clear() async {
    final SharedPreferences? prefs = _preferences;
    if (prefs == null) return false;
    return prefs.clear();
  }
}
