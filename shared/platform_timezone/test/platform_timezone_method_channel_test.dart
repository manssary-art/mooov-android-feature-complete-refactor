import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_timezone/platform_timezone_method_channel.dart';

void main() {
  MethodChannelPlatformTimezone platform = MethodChannelPlatformTimezone();
  const MethodChannel channel = MethodChannel('platform_timezone');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Europe/Stockholm';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformTimezoneOrNull', () async {
    expect(await platform.getPlatformTimezoneOrNull(), 'Europe/Stockholm');
  });
}
