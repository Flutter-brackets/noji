import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/cubit/webview_state.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/solid_bottom_nav_bar.dart';
import 'package:noji/features/webview/presentation/widgets/webview_nav_helper.dart';

class WebviewBottomBarConnector extends StatefulWidget {
  final InAppWebViewController? controller;
  final double bottomInset;

  const WebviewBottomBarConnector({
    super.key,
    required this.controller,
    required this.bottomInset,
  });

  @override
  State<WebviewBottomBarConnector> createState() =>
      _WebviewBottomBarConnectorState();
}

class _WebviewBottomBarConnectorState extends State<WebviewBottomBarConnector> {
  NavTab? _optimisticTab;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebviewCubit, WebviewState>(
      buildWhen: (p, c) =>
          p.isDrawerOpen != c.isDrawerOpen ||
          p.currentUrl != c.currentUrl ||
          p.isLoading != c.isLoading,
      builder: (ctx, s) {
        if (!s.isLoading) _optimisticTab = null;
        final NavTab? computedTab = NavRoutes.getTabFromUrl(s.currentUrl);
        if (computedTab == _optimisticTab) _optimisticTab = null;
        final NavTab? active = _optimisticTab ?? computedTab;
        final bool isEnglish = NavRoutes.isEnglishUrl(s.currentUrl);
        final InAppWebViewController? ctrl =
            widget.controller ?? ctx.read<WebviewCubit>().controller;

        return SolidBottomNavBar(
          activeTab: active,
          isEnglish: isEnglish,
          onTabSelected: (t) {
            setState(() => _optimisticTab = t);
            WebviewNavHelper.handleTabTap(
              ctrl,
              t,
              active,
              currentUrl: s.currentUrl,
            );
          },
          isDrawerOpen: s.isDrawerOpen,
          bottomInset: widget.bottomInset,
        );
      },
    );
  }
}
