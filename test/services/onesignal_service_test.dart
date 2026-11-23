import 'package:flutter_test/flutter_test.dart';
import 'package:noji/core/services/onesignal_service.dart';

void main() {
  group('OneSignalService URL Sanitization Tests', () {
    test('accepts valid https URL on nojiksa.com', () {
      const String url = 'https://nojiksa.com/products/abaya-1';
      expect(OneSignalService.sanitizeUrl(url), equals(url));
    });

    test('accepts valid https URL on nojiksa.com subdomain', () {
      const String url = 'https://store.nojiksa.com/collection/summer';
      expect(OneSignalService.sanitizeUrl(url), equals(url));
    });

    test('rejects insecure http URLs', () {
      const String url = 'http://nojiksa.com/products/abaya-1';
      expect(OneSignalService.sanitizeUrl(url), isNull);
    });

    test('rejects external or unapproved hosts', () {
      expect(OneSignalService.sanitizeUrl('https://google.com'), isNull);
      expect(OneSignalService.sanitizeUrl('https://phishing-noji.com'), isNull);
      expect(OneSignalService.sanitizeUrl('https://zid.sa'), isNull);
    });

    test('rejects malformed or empty URLs', () {
      expect(OneSignalService.sanitizeUrl(''), isNull);
      expect(OneSignalService.sanitizeUrl('   '), isNull);
      expect(OneSignalService.sanitizeUrl(null), isNull);
      expect(OneSignalService.sanitizeUrl('not a valid url!'), isNull);
      expect(OneSignalService.sanitizeUrl('://broken'), isNull);
    });

    test('handles whitespace trimming correctly', () {
      const String url = '  https://nojiksa.com/cart  ';
      expect(
        OneSignalService.sanitizeUrl(url),
        equals('https://nojiksa.com/cart'),
      );
    });
  });
}
