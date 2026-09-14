part of '_activities_providers.dart';

final isWorkingProvider = StateProvider<bool>(
  name: '$_name.isWorkingProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);

final selectedTabProvider = StateProvider<ActivitiesTab>(
  name: '$_name.selectedTabProvider',
  dependencies: _scope.dependencies,
  (ref) => ActivitiesTab.active,
);
