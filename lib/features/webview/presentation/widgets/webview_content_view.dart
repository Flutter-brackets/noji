import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:noji/core/services/notification_prompt_manager.dart';
import 'package:noji/core/services/onesignal_service.dart';
import 'package:noji/core/theme/app_colors.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/widgets/webview_bottom_bar_connector.dart';
import 'package:noji/features/webview/presentation/widgets/webview_nav_helper.dart';
import 'package:noji/features/webview/presentation/widgets/webview_stack_pane.dart';
import 'package:noji/features/webview/presentation/widgets/webview_top_strip.dart';

class WebviewContentView extends StatefulWidget {
  const WebviewContentView({super.key});

  @override
  State<WebviewContentView> createState() => _WebviewContentViewState();
}

class _WebviewContentViewState extends State<WebviewContentView> {
  InAppWebViewController? _controller;
  bool _promptScheduled = false;

  static const SystemUiOverlayStyle _style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    OneSignalService.registerUrlHandler(
        (u) => WebviewNavHelper.openUrl(_controller, u));
  }

  void _onLoadStop(String? u) {
    context.read<WebviewCubit>().onLoadStop(u);
    WebviewNavHelper.verifyLayout(_controller);
    if (_promptScheduled) return;
    _promptScheduled = true;
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (mounted) NotificationPromptManager.checkAndPrompt(context);
    });
  }

  @override
  void dispose() {
    OneSignalService.unregisterUrlHandler();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    final WebviewCubit cubit = context.read<WebviewCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _style,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (d, _) =>
            WebviewNavHelper.handlePop(_controller, d),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.softCream,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.padding.left),
            child: Column(
              children: <Widget>[
                WebviewTopStrip(topInset: mq.viewPadding.top),
                Expanded(
                  child: WebviewStackPane(
                    cubit: cubit,
                    onControllerCreated: (c) {
                      setState(() => _controller = c);
                      cubit.attachController(c);
                    },
                    onLoadStop: _onLoadStop,
                    onRetry: () {
                      cubit.setOffline(false);
                      _controller?.reload();
                    },
                  ),
                ),
                WebviewBottomBarConnector(
                  controller: _controller,
                  bottomInset: mq.viewPadding.bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
