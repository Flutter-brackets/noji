abstract final class AppConstants {
  static const String appName = 'Noji';
  static const String appNameArabic = 'نوجي';
  static const String baseUrl = 'https://nojiksa.com/';

  static const List<String> allowedHosts = <String>[
    'nojiksa.com',
    'sso.zid.store',
    'zid.store',
    'zid.sa',
  ];

  static const String onboardingCacheKey = 'has_seen_onboarding';
  static const String logoAssetPath = 'assets/images/logo.png';
  static const String poweredByHout = 'Powered by Hout';
  static const String oneSignalAppId = 'db57a6e7-e85c-4120-ad35-2d4205e18d32';
  static const String notifPromptCountKey = 'notif_prompt_count';
  static const String notifLastPromptTimeKey = 'notif_last_prompt_time';
}
