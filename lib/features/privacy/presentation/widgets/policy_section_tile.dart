import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/privacy/data/policy_section.dart';

class PolicySectionTile extends StatelessWidget {
  final PolicySection section;
  final bool isLast;

  const PolicySectionTile({
    super.key,
    required this.section,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                section.number,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.warmGold,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryEmerald,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final String paragraph in section.paragraphs) ...<Widget>[
            Text(
              paragraph,
              style: const TextStyle(
                fontSize: 15,
                height: 1.8,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 8),
          ],
          for (final String bullet in section.bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '— ',
                    style: TextStyle(
                      color: AppColors.warmGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.8,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 28),
          if (!isLast) ...<Widget>[
            Container(height: 1, color: const Color(0xFFE8E1D6)),
            const SizedBox(height: 28),
          ],
        ],
      ),
    );
  }
}
