import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/cubit/webview_state.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/solid_bottom_nav_bar.dart';
import 'package:noji/features/webview/presentation/widgets/webview_browser_pane.dart';
import 'package:noji/features/webview/presentation/widgets/webview_nav_helper.dart';
import 'package:noji/features/webview/presentation/widgets/webview_status_overlay.dart';
import 'package:noji/features/webview/presentation/widgets/webview_top_strip.dart';

class WebviewContentView extends StatefulWidget {
  const WebviewContentView({super.key});

  @override
  State<WebviewContentView> createState() => _WebviewContentViewState();
}

class _WebviewContentViewState extends State<WebviewContentView> {
  InAppWebViewController? _controller;
  late final Widget _browserPane;

  static const SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    final WebviewCubit cubit = context.read<WebviewCubit>();
    _browserPane = RepaintBoundary(
      child: WebviewBrowserPane(
        onControllerCreated: (c) {
          _controller = c;
          cubit.attachController(c);
        },
        onLoadStart: (u) => cubit.onLoadStart(u),
        onLoadStop: (u) {
          cubit.onLoadStop(u);
          WebviewNavHelper.verifyLayout(_controller);
        },
        onUpdateVisitedHistory: (u) => cubit.updateUrl(u),
        onReceivedError: () => cubit.setOffline(true),
        onDrawerChanged: (open) => cubit.setDrawerOpen(open),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.viewPaddingOf(context).top;
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final EdgeInsets pad = MediaQuery.paddingOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, _) =>
            WebviewNavHelper.handlePop(_controller, didPop),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.softCream,
          body: Padding(
            padding: EdgeInsets.only(left: pad.left, right: pad.right),
            child: Column(
              children: <Widget>[
                WebviewTopStrip(topInset: topInset),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      _browserPane,
                      WebviewStatusOverlay(onRetry: () {
                        context.read<WebviewCubit>().setOffline(false);
                        _controller?.reload();
                      }),
                    ],
                  ),
                ),
                BlocBuilder<WebviewCubit, WebviewState>(
                  buildWhen: (p, c) =>
                      p.isDrawerOpen != c.isDrawerOpen ||
                      p.currentUrl != c.currentUrl,
                  builder: (ctx, state) {
                    final NavTab? tab =
                        NavRoutes.getTabFromUrl(state.currentUrl);
                    return SolidBottomNavBar(
                      activeTab: tab,
                      onTabSelected: (t) =>
                          WebviewNavHelper.handleTabTap(_controller, t, tab),
                      isDrawerOpen: state.isDrawerOpen,
                      bottomInset: bottomInset,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
