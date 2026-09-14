import 'package:amplitude_flutter/amplitude.dart';

import '../analytics_integration.dart';

class AmplitudeAnalyticsIntegration implements AnalyticsIntegration {
  final String _apiKey;

  AmplitudeAnalyticsIntegration(this._apiKey);

  static const id = 'amplitude';

  late final Future<Amplitude> _delegate = Future.microtask(() => Amplitude(_apiKey));

  @override
  String integrationId = id;

  @override
  Future<void> logEvent(String name, [Map<String, dynamic>? parameters = const {}]) async {
    (await _delegate).logEvent(name, eventProperties: parameters);
  }

  @override
  Future<void> setUserId(String id) async {
    (await _delegate).setUserId(id);
  }
}
