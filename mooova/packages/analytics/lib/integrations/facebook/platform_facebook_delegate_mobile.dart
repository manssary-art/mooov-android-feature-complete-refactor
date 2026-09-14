import 'package:facebook_app_events/facebook_app_events.dart';

class PlatformFacebookDelegate {
  final FacebookAppEvents facebook = FacebookAppEvents();

  Future<void> logEvent(String name, [Map<String, dynamic>? parameters = const {}]) async {
    facebook.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserId(String id) async {
    facebook.setUserID(id);
  }
}
