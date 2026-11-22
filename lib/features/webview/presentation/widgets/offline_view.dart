import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';

class OfflineView extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflineView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.softCream,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.wifi_off_rounded,
              size: 72,
              color: AppColors.warmGold,
            ),
            const SizedBox(height: 24),
            const Text(
              'لا يوجد اتصال بالإنترنت',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryEmerald,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'يرجى التحقق من اتصالك بالشبكة والمحاولة مجدداً.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF6B6B6B),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 180,
              height: 48,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryEmerald,
                  foregroundColor: AppColors.pureWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'إعادة المحاولة',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
