part of '_order_rating_providers.dart';

typedef OrderRatingData = ({OrderModel order, Map<String, String> tags});

final orderRatingProvider = AsyncNotifierProvider<OrderRatingNotifier, OrderRatingData>(
  name: '$_name.orderRatingProvider',
  dependencies: _scope.dependencies,
  () => throw UnimplementedError(),
).scoped(_scope);

class OrderRatingNotifier extends AsyncNotifier<OrderRatingData> {
  final String orderId;

  OrderRatingNotifier(this.orderId);

  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  Future<OrderRatingData> build() async {
    final orderRepository = ref.watch(orderRepositoryProvider);
    final orderRatingRepository = ref.watch(orderRatingRepositoryProvider);

    final orderResult = await orderRepository.getOrderById(orderId: orderId);
    final tagsResult = await orderRatingRepository.fetchRatingTags();

    final order = orderResult.asValue!.value;
    final tags = tagsResult.asValue!.value;

    if (order == null) {
      throw Exception('Could not fetch order $orderId');
    }

    return (order: order, tags: tags);
  }

  void onNavBackClicked() {
    _sideEffect().add(const OrderRatingSideEffect$NavBack());
  }
}
