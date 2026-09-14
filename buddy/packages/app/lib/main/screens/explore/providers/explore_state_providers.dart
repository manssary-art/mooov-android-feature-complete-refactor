part of '_explore_providers.dart';

final selectedTabProvider = StateProvider<ExploreTab>(
  name: '$_name.selectedTabProvider',
  dependencies: _scope.dependencies,
  (ref) => ExploreTab.all,
).scoped(_scope);
