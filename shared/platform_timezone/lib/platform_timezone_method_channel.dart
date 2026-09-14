import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_timezone_platform_interface.dart';

/// An implementation of [PlatformTimezonePlatform] that uses method channels.
class MethodChannelPlatformTimezone extends PlatformTimezonePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_timezone');

  @override
  Future<String?> getPlatformTimezoneOrNull() async {
    try {
      return await methodChannel.invokeMethod<String?>(
        'getPlatformTimezoneOrNull',
      );
    } catch (e) {
      return null;
    }
  }
}
