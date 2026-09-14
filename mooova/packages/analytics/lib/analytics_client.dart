import 'analytics_event.dart';
import 'integrations/analytics_integration.dart';

abstract class AnalyticsClient {
  const AnalyticsClient._();

  static void logEvent(AnalyticsEvent event) {
    if (event is AnalyticsEventBundle) {
      event.events.forEach(logEvent);
      return;
    }

    if (event is AnalyticsEventData) {
      for (var integration in AnalyticsIntegration.integrations) {
        if (event.integration != null && event.integration != integration.integrationId) {
          continue;
        }

        integration.logEvent(event.event, event.params);
      }
      return;
    }
  }

  static void setUserId(String id) {
    for (var element in AnalyticsIntegration.integrations) {
      element.setUserId(id);
    }
  }
}
