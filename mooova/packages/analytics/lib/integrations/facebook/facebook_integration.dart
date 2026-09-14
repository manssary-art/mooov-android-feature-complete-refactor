import '../analytics_integration.dart';
import 'platform_facebook_delegate.dart' if (dart.library.io) 'platform_facebook_delegate_mobile.dart';

class FacebookAnalyticsIntegrations implements AnalyticsIntegration {
  static const id = 'facebook';

  late final Future<PlatformFacebookDelegate> _delegate = Future.microtask(() => PlatformFacebookDelegate());

  @override
  String integrationId = id;

  @override
  Future<void> logEvent(String name, [Map<String, dynamic>? parameters = const {}]) async {
    (await _delegate).logEvent(name, parameters);
  }

  @override
  Future<void> setUserId(String id) async {
    (await _delegate).setUserId(id);
  }
}
