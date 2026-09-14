import 'package:dio/dio.dart';

class DioClientInfoInterceptor extends InterceptorsWrapper {
  static Future<String?> Function() getLanguageCode = () => Future.value(null);
  static Future<String?> Function() getTimezone = () => Future.value(null);
  static Future<String?> Function() getPlatform = () => Future.value(null);
  static Future<String?> Function() getVersion = () => Future.value(null);
  static Future<String?> Function() getBuild = () => Future.value(null);

  static final cache = <String, String>{};

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final localeValue = cache['locale'] ?? await getLanguageCode();
    if (localeValue != null) {
      cache['locale'] = localeValue;
      options.queryParameters['locale'] = localeValue;
    }

    final timezoneValue = cache['timezone'] ?? await getTimezone();
    if (timezoneValue != null) {
      cache['timezone'] = timezoneValue;
      options.queryParameters['timezone'] = timezoneValue;
    }

    final platformValue = cache['platform'] ?? await getPlatform();
    if (platformValue != null) {
      cache['platform'] = platformValue;
      options.queryParameters['platform'] = platformValue;
    }

    final versionValue = cache['version'] ?? await getVersion();
    if (versionValue != null) {
      cache['version'] = versionValue;
      options.queryParameters['version'] = versionValue;
    }

    final buildVersion = cache['build'] ?? await getBuild();
    if (buildVersion != null) {
      cache['build'] = buildVersion;
      options.queryParameters['build'] = buildVersion;
    }

    handler.next(options);
  }
}
