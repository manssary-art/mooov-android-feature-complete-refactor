part of '_order_rating_providers.dart';

final orderRatingActionProvider = Provider(
  name: '$_name.orderRatingActionProvider',
  dependencies: _scope.dependencies,
  (ref) => OrderRatingAction(ref),
).scoped(_scope);

class OrderRatingAction {
  final Ref ref;

  OrderRatingAction(this.ref);

  Future<void> onSubmitClicked({
    required String orderId,
    required String workerId,
  }) async {
    final orderRatingRepository = ref.read(orderRatingRepositoryProvider);
    final rating = ref.read(ratingProvider);
    final description = ref.read(descriptionProvider);
    final selectedTags = ref.read(selectedTagsProvider);

    final result = await orderRatingRepository.rateOrder(
      orderId: orderId,
      workerId: workerId,
      rate: rating.toDouble(),
      tags: selectedTags,
      comment: description,
    );

    final sideEffect = ref.read(sideEffectProvider);
    if (result.isValue) {
      sideEffect.add(const OrderRatingSideEffect$NavBack());
    } else {
      sideEffect.add(const OrderRatingSideEffect$ShowError());
    }
  }
}
