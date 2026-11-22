enum NavTab { home, categories, cart, account }

extension NavTabUrl on NavTab {
  String get url => switch (this) {
        NavTab.home => NavRoutes.home,
        NavTab.categories => NavRoutes.categories,
        NavTab.cart => NavRoutes.cart,
        NavTab.account => NavRoutes.account,
      };
}

abstract final class NavRoutes {
  static const String home = 'https://nojiksa.com/';
  static const String categories = 'https://nojiksa.com/categories';
  static const String cart = 'https://nojiksa.com/cart';
  static const String account = 'https://nojiksa.com/account';

  static NavTab? getTabFromUrl(String? urlStr) {
    if (urlStr == null || urlStr.trim().isEmpty) return NavTab.home;
    final Uri? uri = Uri.tryParse(urlStr);
    if (uri == null) return null;

    final String host = uri.host.toLowerCase();
    final String path = uri.path.toLowerCase();

    if (host.contains('sso.zid.store') ||
        path.startsWith('/account') ||
        path.startsWith('/auth')) {
      return NavTab.account;
    }
    if (path.startsWith('/cart')) {
      return NavTab.cart;
    }
    if (path.startsWith('/categories')) {
      return NavTab.categories;
    }
    if ((host.isEmpty || host.contains('nojiksa.com')) &&
        (path.isEmpty || path == '/')) {
      return NavTab.home;
    }
    return null;
  }

  static bool shouldHideNav(String? urlStr) {
    if (urlStr == null || urlStr.trim().isEmpty) return false;
    final Uri? uri = Uri.tryParse(urlStr);
    if (uri == null) return false;

    final String host = uri.host.toLowerCase();
    final String path = uri.path.toLowerCase();

    if (host.contains('sso.zid.store') ||
        path.startsWith('/auth') ||
        path.startsWith('/checkout') ||
        path.startsWith('/payment')) {
      return true;
    }
    return false;
  }
}
