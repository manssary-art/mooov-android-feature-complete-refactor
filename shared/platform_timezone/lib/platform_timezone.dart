import 'platform_timezone_platform_interface.dart';

class PlatformTimezone {
  PlatformTimezone._();

  static String? platformTimezoneCache;

  static Future<String?> getPlatformTimezoneOrNull() async {
    platformTimezoneCache ??= await PlatformTimezonePlatform.instance.getPlatformTimezoneOrNull();
    return Future.value(platformTimezoneCache);
  }
}
