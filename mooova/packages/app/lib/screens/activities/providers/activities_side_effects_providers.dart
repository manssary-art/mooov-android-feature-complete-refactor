part of '_activities_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<ActivitiesSideEffect>.broadcast(),
).scoped(_scope);

sealed class ActivitiesSideEffect {}

class ActivitiesSideEffect$NavToProfile implements ActivitiesSideEffect {
  const ActivitiesSideEffect$NavToProfile();
}

class ActivitiesSideEffect$OpenUrl implements ActivitiesSideEffect {
  final String url;

  const ActivitiesSideEffect$OpenUrl({required this.url});
}
