import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/privacy/data/privacy_policy_content.dart';

class PolicyHeader extends StatelessWidget {
  const PolicyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'نوجي',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.warmGold,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'آخر تحديث: ${PrivacyPolicyContent.lastUpdated}',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF8A8A8A),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16),
          Text(
            PrivacyPolicyContent.intro,
            style: TextStyle(
              fontSize: 15,
              height: 1.8,
              color: Color(0xFF4A4A4A),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
