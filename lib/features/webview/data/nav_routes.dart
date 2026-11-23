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

  static final RegExp _localeRegExp = RegExp(
    r'^/(ar|en)(-[a-z]{2})?(?=/|$)',
    caseSensitive: false,
  );

  static bool isEnglishUrl(String? urlStr) {
    if (urlStr == null) return false;
    final Uri? uri = Uri.tryParse(urlStr);
    final String path = (uri?.path ?? urlStr).toLowerCase();
    return RegExp(
      r'^/en(-[a-z]{2})?(?=/|$)',
      caseSensitive: false,
    ).hasMatch(path);
  }

  static String getTabUrl(NavTab tab, [String? currentUrl]) {
    String prefix = 'https://nojiksa.com';
    if (currentUrl != null && currentUrl.isNotEmpty) {
      final Uri? uri = Uri.tryParse(currentUrl);
      if (uri != null) {
        final Match? match = _localeRegExp.firstMatch(uri.path);
        if (match != null) {
          prefix = '${uri.scheme}://${uri.host}${match.group(0)}';
        }
      }
    }
    return switch (tab) {
      NavTab.home => '$prefix/',
      NavTab.categories => '$prefix/categories',
      NavTab.cart => '$prefix/cart',
      NavTab.account => '$prefix/account',
    };
  }

  static NavTab? getTabFromUrl(String? urlStr) {
    if (urlStr == null || urlStr.trim().isEmpty) return NavTab.home;
    final Uri? uri = Uri.tryParse(urlStr);
    if (uri == null) return null;

    final String host = uri.host.toLowerCase();
    String path = uri.path.toLowerCase().replaceFirst(_localeRegExp, '');
    if (path.endsWith('/') && path.length > 1) {
      path = path.substring(0, path.length - 1);
    }

    if (host.contains('sso.zid.store') ||
        path.startsWith('/account') ||
        path.startsWith('/customer') ||
        path.startsWith('/auth')) {
      return NavTab.account;
    }
    if (path.startsWith('/cart')) return NavTab.cart;
    if (path.startsWith('/categories')) return NavTab.categories;
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
    final String path = uri.path.toLowerCase().replaceFirst(_localeRegExp, '');

    return host.contains('sso.zid.store') ||
        path.startsWith('/auth') ||
        path.startsWith('/checkout') ||
        path.startsWith('/payment');
  }
}
