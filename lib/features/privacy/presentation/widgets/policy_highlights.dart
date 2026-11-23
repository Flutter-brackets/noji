import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';

class PolicyHighlights extends StatelessWidget {
  const PolicyHighlights({super.key});

  Widget _buildItem(String title) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryEmerald,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildStackedItem(String title) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryEmerald,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 22,
      color: AppColors.warmGold,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isNarrow = MediaQuery.sizeOf(context).width < 340;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8E1D6), width: 1),
        ),
        child: isNarrow
            ? Column(
                children: <Widget>[
                  _buildStackedItem('لا نبيع بياناتك'),
                  const Divider(color: AppColors.warmGold, height: 16),
                  _buildStackedItem('مدفوعات آمنة'),
                  const Divider(color: AppColors.warmGold, height: 16),
                  _buildStackedItem('أنتِ المتحكمة ببياناتك'),
                ],
              )
            : Row(
                children: <Widget>[
                  _buildItem('لا نبيع بياناتك'),
                  _buildDivider(),
                  _buildItem('مدفوعات آمنة'),
                  _buildDivider(),
                  _buildItem('أنتِ المتحكمة ببياناتك'),
                ],
              ),
      ),
    );
  }
}
