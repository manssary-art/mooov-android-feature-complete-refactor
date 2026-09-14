// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'platform_timezone_platform_interface.dart';

/// A web implementation of the PlatformTimezonePlatform of the PlatformTimezone plugin.
class PlatformTimezoneWeb extends PlatformTimezonePlatform {
  /// Constructs a PlatformTimezoneWeb
  PlatformTimezoneWeb();

  static void registerWith(Registrar registrar) {
    PlatformTimezonePlatform.instance = PlatformTimezoneWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformTimezoneOrNull() async {
    try {
      final dtf = js.context['Intl']?.callMethod('DateTimeFormat');
      final ops = dtf?.callMethod('resolvedOptions');
      if (ops != null) {
        return ops['timeZone'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
