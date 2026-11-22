import 'package:flutter_test/flutter_test.dart';
import 'package:noji/features/webview/data/nav_routes.dart';

void main() {
  group('NavRoutes Tests', () {
    test('Tab constants match verified endpoints', () {
      expect(NavRoutes.home, 'https://nojiksa.com/');
      expect(NavRoutes.categories, 'https://nojiksa.com/categories');
      expect(NavRoutes.cart, 'https://nojiksa.com/cart');
      expect(NavRoutes.account, 'https://nojiksa.com/account');
    });

    test('getTabFromUrl detects active tab correctly', () {
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/'), NavTab.home);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com'), NavTab.home);
      expect(NavRoutes.getTabFromUrl(null), NavTab.home);
      expect(NavRoutes.getTabFromUrl(''), NavTab.home);

      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/categories'),
          NavTab.categories);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/categories/123'),
          NavTab.categories);

      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/cart'), NavTab.cart);
      expect(
          NavRoutes.getTabFromUrl('https://nojiksa.com/cart/view'), NavTab.cart);

      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/account'),
          NavTab.account);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/account/orders'),
          NavTab.account);
      expect(NavRoutes.getTabFromUrl('https://nojiksa.com/auth/login'),
          NavTab.account);
      expect(
          NavRoutes.getTabFromUrl(
              'https://sso.zid.store/auth/login?redirect_to=https://nojiksa.com'),
          NavTab.account);
    });

    test('shouldHideNav accurately flags hide-eligible routes', () {
      expect(
          NavRoutes.shouldHideNav(
              'https://sso.zid.store/auth/login?redirect_to=https://nojiksa.com'),
          isTrue);
      expect(
          NavRoutes.shouldHideNav('https://nojiksa.com/auth/login'), isTrue);
      expect(
          NavRoutes.shouldHideNav('https://nojiksa.com/checkout'), isTrue);
      expect(
          NavRoutes.shouldHideNav('https://nojiksa.com/payment'), isTrue);

      expect(NavRoutes.shouldHideNav('https://nojiksa.com/'), isFalse);
      expect(NavRoutes.shouldHideNav('https://nojiksa.com/categories'),
          isFalse);
      expect(NavRoutes.shouldHideNav('https://nojiksa.com/cart'), isFalse);
    });
  });
}
