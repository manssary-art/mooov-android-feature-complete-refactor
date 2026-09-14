abstract class AnalyticsIntegration {
  String get integrationId;

  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]);

  Future<void> setUserId(String id);

  static List<AnalyticsIntegration> integrations = [];
}
