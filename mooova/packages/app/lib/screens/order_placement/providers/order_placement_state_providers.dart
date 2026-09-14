part of '_order_placement_providers.dart';

final isWorkingProvider = StateProvider<bool>(
  name: '$_name.isWorkingProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);

final descriptionProvider = StateProvider<String>(
  name: '$_name.descriptionProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(orderPlacementProvider).value?.$2?.description ?? '',
).scoped(_scope);

final numOfWorkersRequestedProvider = StateProvider<int>(
  name: '$_name.numOfWorkersRequestedProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(orderPlacementProvider).value?.$2?.numOfWorkersRequested ?? 1,
).scoped(_scope);

final productConditionProvider = StateProvider<ProductCondition>(
  name: '$_name.productConditionProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(orderPlacementProvider).value?.$2?.productCondition ?? ProductCondition.good,
).scoped(_scope);

final orderSizeProvider = StateProvider<OrderSize>(
  name: '$_name.orderSizeProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(orderPlacementProvider).value?.$2?.orderSize ?? OrderSize.l,
).scoped(_scope);

final recommendationsProvider = StateProvider<Map<OrderSize, OrderPriceRecommendationModel>>(
  name: '$_name.recommendationsProvider',
  dependencies: _scope.dependencies,
  (ref) => <OrderSize, OrderPriceRecommendationModel>{},
).scoped(_scope);

final recommendationProvider = Provider<OrderPriceRecommendationModel?>(
  name: '$_name.recommendationProvider',
  dependencies: _scope.dependencies,
  (ref) {
    final recommendations = ref.watch(recommendationsProvider);
    final size = ref.watch(orderSizeProvider);
    return recommendations[size] ?? recommendations.values.firstOrNull();
  },
).scoped(_scope);

final pickUpTimesProvider = StateProvider<List<DateTime>>(
  name: '$_name.pickUpTimesProvider',
  dependencies: _scope.dependencies,
  (ref) => <DateTime>[],
).scoped(_scope);

final isTermAcceptedProvider = StateProvider<bool>(
  name: '$_name.isTermAcceptedProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);
