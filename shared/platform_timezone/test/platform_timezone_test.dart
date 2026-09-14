import 'package:flutter_test/flutter_test.dart';
import 'package:platform_timezone/platform_timezone.dart';
import 'package:platform_timezone/platform_timezone_method_channel.dart';
import 'package:platform_timezone/platform_timezone_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlatformTimezonePlatform with MockPlatformInterfaceMixin implements PlatformTimezonePlatform {
  @override
  Future<String?> getPlatformTimezoneOrNull() => Future.value('Europe/Stockholm');
}

void main() {
  final PlatformTimezonePlatform initialPlatform = PlatformTimezonePlatform.instance;

  test('$MethodChannelPlatformTimezone is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlatformTimezone>());
  });

  test('getPlatformTimezoneOrNull', () async {
    MockPlatformTimezonePlatform fakePlatform = MockPlatformTimezonePlatform();
    PlatformTimezonePlatform.instance = fakePlatform;

    expect(await PlatformTimezone.getPlatformTimezoneOrNull(), 'Europe/Stockholm');
  });
}
