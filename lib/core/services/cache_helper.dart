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

  static Future<bool> clear() async {
    final SharedPreferences? prefs = _preferences;
    if (prefs == null) return false;
    return prefs.clear();
  }
}
