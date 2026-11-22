import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/data/url_handler_service.dart';
import 'package:noji/features/webview/data/webview_prewarmer.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/nav_bar_style.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/url_launcher'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'canLaunch') return true;
        if (methodCall.method == 'launch') return true;
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/url_launcher'),
      null,
    );
  });

  group('UrlHandlerService Tests', () {
    test('Allowed hosts return true', () async {
      expect(await UrlHandlerService.handleUrl('https://nojiksa.com/'), isTrue);
      expect(
          await UrlHandlerService.handleUrl('https://sso.zid.store/auth'), isTrue);
      expect(
          await UrlHandlerService.handleUrl('https://zid.store/products'), isTrue);
    });

    test('External or social hosts return false', () async {
      expect(await UrlHandlerService.handleUrl('https://google.com'), isFalse);
      expect(
          await UrlHandlerService.handleUrl('https://wa.me/966500000000'), isFalse);
      expect(
          await UrlHandlerService.handleUrl('mailto:test@example.com'), isFalse);
    });
  });

  group('WebviewCubit Tests', () {
    test('Initial state is correct', () {
      final WebviewCubit cubit = WebviewCubit();
      expect(cubit.state.isLoading, isTrue);
      expect(cubit.state.isOffline, isFalse);
      expect(cubit.state.hasLoadedOnce, isFalse);
      expect(cubit.state.isDrawerOpen, isFalse);
      cubit.close();
    });

    test('onLoadStop marks hasLoadedOnce true', () {
      final WebviewCubit cubit = WebviewCubit();
      cubit.onLoadStop('https://nojiksa.com/');
      expect(cubit.state.isLoading, isFalse);
      expect(cubit.state.hasLoadedOnce, isTrue);
      expect(cubit.state.currentUrl, 'https://nojiksa.com/');
      cubit.close();
    });

    test('setDrawerOpen updates state and onLoadStart resets it', () {
      final WebviewCubit cubit = WebviewCubit();
      cubit.setDrawerOpen(true);
      expect(cubit.state.isDrawerOpen, isTrue);
      cubit.onLoadStart('https://nojiksa.com/categories');
      expect(cubit.state.isDrawerOpen, isFalse);
      cubit.close();
    });
  });

  group('NavBarStyle & Prewarmer Tests', () {
    test('Presets are correctly initialized with softGreen as current', () {
      expect(NavBarStyle.softGreen.borderRadius, 26.0);
      expect(NavBarStyle.cream.borderRadius, 26.0);
      expect(NavBarStyle.emerald.borderRadius, 26.0);
      expect(NavBarStyle.current, equals(NavBarStyle.softGreen));
    });

    test('WebviewPrewarmer provides active keepAlive instance', () {
      expect(WebviewPrewarmer.activeKeepAlive, isNotNull);
    });
  });
}
