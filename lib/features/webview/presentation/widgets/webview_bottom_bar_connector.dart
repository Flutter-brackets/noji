import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/cubit/webview_state.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/solid_bottom_nav_bar.dart';
import 'package:noji/features/webview/presentation/widgets/webview_nav_helper.dart';

class WebviewBottomBarConnector extends StatelessWidget {
  final InAppWebViewController? controller;
  final double bottomInset;

  const WebviewBottomBarConnector({
    super.key,
    required this.controller,
    required this.bottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebviewCubit, WebviewState>(
      buildWhen: (p, c) =>
          p.isDrawerOpen != c.isDrawerOpen || p.currentUrl != c.currentUrl,
      builder: (_, s) {
        final NavTab? tab = NavRoutes.getTabFromUrl(s.currentUrl);
        return SolidBottomNavBar(
          activeTab: tab,
          onTabSelected: (t) =>
              WebviewNavHelper.handleTabTap(controller, t, tab),
          isDrawerOpen: s.isDrawerOpen,
          bottomInset: bottomInset,
        );
      },
    );
  }
}
