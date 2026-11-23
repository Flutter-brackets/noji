import 'package:flutter/material.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/privacy/data/policy_section.dart';
import 'package:noji/features/privacy/data/privacy_policy_content.dart';
import 'package:noji/features/privacy/presentation/widgets/policy_contact_block.dart';
import 'package:noji/features/privacy/presentation/widgets/policy_header.dart';
import 'package:noji/features/privacy/presentation/widgets/policy_highlights.dart';
import 'package:noji/features/privacy/presentation/widgets/policy_section_tile.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const PrivacyPolicyScreen(),
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, Animation<double> anim, _, Widget child) {
          final CurvedAnimation curved = CurvedAnimation(
            parent: anim,
            curve: Curves.easeOutCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curved),
            child: FadeTransition(opacity: curved, child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isScrolled = ValueNotifier<bool>(false);
    final List<PolicySection> sections = PrivacyPolicyContent.allSections;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SelectionArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification n) {
                final bool scrolled = n.metrics.pixels > 10;
                if (isScrolled.value != scrolled) isScrolled.value = scrolled;
                return false;
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: AppColors.softCream,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    pinned: true,
                    leading: const BackButton(color: AppColors.primaryEmerald),
                    title: const Text(
                      'سياسة الخصوصية',
                      style: TextStyle(
                        color: AppColors.primaryEmerald,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(1),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isScrolled,
                        builder: (_, bool scrolled, _) => Container(
                          height: 1,
                          color: scrolled
                              ? AppColors.warmGold
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: PolicyHeader()),
                  const SliverToBoxAdapter(child: PolicyHighlights()),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext ctx, int i) => PolicySectionTile(
                        section: sections[i],
                        isLast: i == sections.length - 1,
                      ),
                      childCount: sections.length,
                    ),
                  ),
                  const SliverToBoxAdapter(child: PolicyContactBlock()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
