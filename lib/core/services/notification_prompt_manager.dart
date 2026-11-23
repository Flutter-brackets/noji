import 'package:flutter/material.dart';
import 'package:noji/core/services/cache_helper.dart';
import 'package:noji/core/services/onesignal_service.dart';
import 'package:noji/core/widgets/notification_permission_prompt.dart';

abstract final class NotificationPromptManager {
  static bool shouldPrompt({
    required bool hasSeenOnboarding,
    required bool hasPermission,
    DateTime? now,
  }) {
    if (!hasSeenOnboarding) return false;
    if (hasPermission) return false;
    return CacheHelper.shouldPromptNotification(now: now);
  }

  static Future<void> checkAndPrompt(BuildContext context) async {
    final bool eligible = shouldPrompt(
      hasSeenOnboarding: CacheHelper.hasSeenOnboarding(),
      hasPermission: OneSignalService.hasPermission,
    );
    if (!eligible || !context.mounted) return;

    await CacheHelper.recordNotificationPrompt();
    if (!context.mounted) return;
    await NotificationPermissionPrompt.show(context);
  }
}
