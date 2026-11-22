import 'package:noji/core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

abstract final class UrlHandlerService {
  static Future<bool> handleUrl(String urlString) async {
    final Uri? uri = Uri.tryParse(urlString);
    if (uri == null) return false;

    final String scheme = uri.scheme.toLowerCase();
    if (scheme == 'tel' || scheme == 'mailto') {
      await _launchExternal(uri);
      return false;
    }

    final String host = uri.host.toLowerCase();
    if (scheme == 'whatsapp' ||
        host.contains('wa.me') ||
        host.contains('whatsapp.com')) {
      await _launchExternal(uri);
      return false;
    }

    for (final String allowedHost in AppConstants.allowedHosts) {
      if (host == allowedHost || host.endsWith('.$allowedHost')) {
        return true;
      }
    }

    await _launchExternal(uri);
    return false;
  }

  static Future<void> _launchExternal(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
