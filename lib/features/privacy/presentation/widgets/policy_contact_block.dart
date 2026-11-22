import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/privacy/data/privacy_policy_content.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyContactBlock extends StatelessWidget {
  const PolicyContactBlock({super.key});

  Future<void> _sendEmail({String? subject, String? body}) async {
    final Map<String, String> params = <String, String>{};
    if (subject != null) params['subject'] = subject;
    if (body != null) params['body'] = body;

    final Uri uri = Uri(
      scheme: 'mailto',
      path: PrivacyPolicyContent.supportEmail,
      queryParameters: params.isEmpty ? null : params,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 36),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8E1D6), width: 1),
        ),
        child: Column(
          children: <Widget>[
            const Text(
              'تواصلي معنا',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryEmerald,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => _sendEmail(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryEmerald,
                  foregroundColor: AppColors.pureWhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'راسلينا',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () => _sendEmail(
                  subject: 'طلب حذف حساب وبيانات',
                  body:
                      'السلام عليكم،\nأرغب في حذف حسابي وجميع بياناتي من تطبيق نوجي.\nوشكراً.',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryEmerald,
                  side: const BorderSide(
                    color: AppColors.primaryEmerald,
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'طلب حذف الحساب',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '© نوجي — جميع الحقوق محفوظة',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF8A8A8A),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
