import 'package:firebase_analytics/firebase_analytics.dart';

import '../analytics_integration.dart';

class FirebaseAnalyticsIntegration implements AnalyticsIntegration {
  static const id = 'firebase';

  late final Future<FirebaseAnalytics> _delegate = Future.microtask(() => FirebaseAnalytics.instance);

  @override
  String integrationId = id;

  @override
  Future<void> logEvent(String name, [Map<String, dynamic>? parameters = const {}]) async {
    (await _delegate).logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setUserId(String id) async {
    (await _delegate).setUserId(id: id);
  }
}
