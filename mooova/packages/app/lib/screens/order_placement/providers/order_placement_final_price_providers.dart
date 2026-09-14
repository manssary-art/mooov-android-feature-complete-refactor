part of '_order_placement_providers.dart';

final finalPriceProvider = StateProvider<Money>(
  name: '$_name.finalPriceProvider',
  dependencies: _scope.dependencies,
  (ref) {
    _onListenRecommendation(ref);
    _onListenNumOfWorkerRequested(ref);
    return ref.watch(orderPlacementProvider).value?.$2?.finalPrice ?? 0.0;
  },
).scoped(_scope);

void _onListenRecommendation(
  StateProviderRef<Money> ref,
) =>
    ref.listen(recommendationProvider, (previous, next) {
      final numOfWorkersRequested = ref.read(numOfWorkersRequestedProvider);
      if (next == null) return;
      var newPrice = next.estimatedPrice;
      if (numOfWorkersRequested > 1) newPrice += next.additionalWorkerPrice;
      ref.controller.state = newPrice;
    });

void _onListenNumOfWorkerRequested(
  StateProviderRef<Money> ref,
) =>
    ref.listen(numOfWorkersRequestedProvider, (previous, next) {
      final recommendation = ref.read(recommendationProvider);
      if (recommendation == null) return;
      if (next > 1) {
        ref.controller.state += recommendation.additionalWorkerPrice;
      } else {
        ref.controller.state -= recommendation.additionalWorkerPrice;
      }
    });
