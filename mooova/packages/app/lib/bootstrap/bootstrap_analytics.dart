part of 'bootstrap.dart';

Future<void> _bootstrapAnalytics() async {
  if (!kReleaseMode || Env.amplitudeApiKey != null) return;
  AnalyticsIntegration.integrations = [
    FirebaseAnalyticsIntegration(),
    FacebookAnalyticsIntegrations(),
    AmplitudeAnalyticsIntegration(Env.amplitudeApiKey!),
  ];
}
