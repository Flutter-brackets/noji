import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/data/nav_routes.dart';
import 'package:noji/features/webview/presentation/widgets/bottom_nav/solid_bottom_nav_bar.dart';

void main() {
  group('NavRoutes Regression Tests', () {
    test('Localized URLs match correct tabs and detect language', () {
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/ar-sa/'), NavTab.home);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/en-sa/'), NavTab.home);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/ar-sa/categories'),
          NavTab.categories);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/en-sa/categories'),
          NavTab.categories);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/en-sa/customer/profile'),
          NavTab.account);
      expect(NavRoutes.isEnglishUrl('https://nojiksa.com/en-sa/'), isTrue);
      expect(NavRoutes.isEnglishUrl('https://nojiksa.com/ar-sa/'), isFalse);
    });

    test('getTabUrl preserves locale prefix', () {
      const String en = 'https://nojiksa.com/en-sa/products';
      const String ar = 'https://nojiksa.com/ar-sa/products';
      expect(NavRoutes.getTabUrl(NavTab.home, en), 'https://nojiksa.com/en-sa/');
      expect(NavRoutes.getTabUrl(NavTab.categories, en),
          'https://nojiksa.com/en-sa/categories');
      expect(NavRoutes.getTabUrl(NavTab.cart, ar), 'https://nojiksa.com/ar-sa/cart');
    });

    testWidgets('SolidBottomNavBar renders correct labels for Arabic and English',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          bottomNavigationBar: SolidBottomNavBar(
            activeTab: NavTab.home,
            onTabSelected: (_) {},
            isDrawerOpen: false,
            bottomInset: 0,
            isEnglish: false,
          ),
        ),
      ));
      expect(find.text('الرئيسية'), findsOneWidget);
      expect(find.text('الأقسام'), findsOneWidget);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          bottomNavigationBar: SolidBottomNavBar(
            activeTab: NavTab.home,
            onTabSelected: (_) {},
            isDrawerOpen: false,
            bottomInset: 0,
            isEnglish: true,
          ),
        ),
      ));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);
    });
  });
}
