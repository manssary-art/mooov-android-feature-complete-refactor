part of '_order_rating_providers.dart';

final ratingProvider = StateProvider<int>(
  name: '$_name.ratingProvider',
  dependencies: _scope.dependencies,
  (ref) => 5,
).scoped(_scope);

final descriptionProvider = StateProvider<String>(
  name: '$_name.descriptionProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final selectedTagsProvider = StateProvider<List<String>>(
  name: '$_name.selectedTagsProvider',
  dependencies: _scope.dependencies,
  (ref) => [],
).scoped(_scope);
