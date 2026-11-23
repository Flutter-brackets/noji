import 'package:flutter/material.dart';
import 'package:noji/core/responsive/responsive_context.dart';
import 'package:noji/core/services/onesignal_service.dart';
import 'package:noji/core/theme/app_colors.dart';

class NotificationPermissionPrompt extends StatelessWidget {
  const NotificationPermissionPrompt({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NotificationPermissionPrompt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPad = MediaQuery.viewPaddingOf(context).bottom;
    final double maxW = context.isCompact ? double.infinity : 440.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxW),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.softCream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.fromLTRB(28, 16, 28, bottomPad + 20),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 44,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.warmGold,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'فعّلي الإشعارات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryEmerald,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'لنبلغكِ أولاً بالتشكيلات الجديدة والعروض الحصرية.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      OneSignalService.requestPermission();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryEmerald,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('تفعيل',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('لاحقاً',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8A8A8A),
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
