import 'package:flutter_test/flutter_test.dart';
import 'package:noji/core/services/cache_helper.dart';
import 'package:noji/core/services/notification_prompt_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await CacheHelper.init();
  });

  group('NotificationPromptManager Scheduling Tests', () {
    test('does not prompt if onboarding not seen', () {
      final bool prompt = NotificationPromptManager.shouldPrompt(
        hasSeenOnboarding: false,
        hasPermission: false,
      );
      expect(prompt, isFalse);
    });

    test('does not prompt if permission already granted', () {
      final bool prompt = NotificationPromptManager.shouldPrompt(
        hasSeenOnboarding: true,
        hasPermission: true,
      );
      expect(prompt, isFalse);
    });

    test('prompts if onboarding seen, no permission, and never asked before',
        () {
      final bool prompt = NotificationPromptManager.shouldPrompt(
        hasSeenOnboarding: true,
        hasPermission: false,
      );
      expect(prompt, isTrue);
    });

    test('does not prompt if asked within the last 3 days', () async {
      final DateTime now = DateTime(2026, 11, 23, 12, 0);
      await CacheHelper.recordNotificationPrompt(
        now: now.subtract(const Duration(days: 2)),
      );

      final bool prompt = NotificationPromptManager.shouldPrompt(
        hasSeenOnboarding: true,
        hasPermission: false,
        now: now,
      );
      expect(prompt, isFalse);
    });

    test('prompts if last prompt was 3 or more days ago', () async {
      final DateTime now = DateTime(2026, 11, 23, 12, 0);
      await CacheHelper.recordNotificationPrompt(
        now: now.subtract(const Duration(days: 3, hours: 1)),
      );

      final bool prompt = NotificationPromptManager.shouldPrompt(
        hasSeenOnboarding: true,
        hasPermission: false,
        now: now,
      );
      expect(prompt, isTrue);
    });

    test('does not prompt if asked 3 or more times', () async {
      final DateTime now = DateTime(2026, 11, 23, 12, 0);
      await CacheHelper.setNotificationPromptCount(3);

      final bool prompt = NotificationPromptManager.shouldPrompt(
        hasSeenOnboarding: true,
        hasPermission: false,
        now: now,
      );
      expect(prompt, isFalse);
    });
  });
}
