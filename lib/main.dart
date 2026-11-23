import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/constants/app_constants.dart';
import 'core/responsive/orientation_manager.dart';
import 'core/services/cache_helper.dart';
import 'core/services/onesignal_service.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/webview/data/webview_prewarmer.dart';
import 'features/webview/data/webview_timing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignalService.init();
  WebviewTiming.init();
  await CacheHelper.init();
  unawaited(WebviewPrewarmer.prewarm());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.softCream,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const NojiApp());
}

class NojiApp extends StatelessWidget {
  const NojiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (BuildContext context, Widget? child) {
        OrientationManager.update(context);
        final MediaQueryData data = MediaQuery.of(context);
        final TextScaler clampedScaler = data.textScaler.clamp(
          minScaleFactor: 0.9,
          maxScaleFactor: 1.3,
        );
        return MediaQuery(
          data: data.copyWith(textScaler: clampedScaler),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const SplashScreen(),
    );
  }
}
