import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_timezone_method_channel.dart';

abstract class PlatformTimezonePlatform extends PlatformInterface {
  /// Constructs a PlatformTimezonePlatform.
  PlatformTimezonePlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformTimezonePlatform _instance = MethodChannelPlatformTimezone();

  /// The default instance of [PlatformTimezonePlatform] to use.
  ///
  /// Defaults to [MethodChannelPlatformTimezone].
  static PlatformTimezonePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformTimezonePlatform] when
  /// they register themselves.
  static set instance(PlatformTimezonePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformTimezoneOrNull() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
