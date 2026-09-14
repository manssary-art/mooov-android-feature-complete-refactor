part of '_order_details_providers.dart';

final ownerProvider = NotifierProvider<OrderDetailsOwnerNotifier, bool>(
  name: '$_name.workerProvider',
  dependencies: _scope.dependencies,
  () => OrderDetailsOwnerNotifier(),
).scoped(_scope);

class OrderDetailsOwnerNotifier extends Notifier<bool> {
  late final _orderRepository = () => ref.read(orderRepositoryProvider);
  late final _displayMode = () => ref.read(displayModeProvider);
  late final _orderDetails = () => ref.read(orderDetailsProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  bool build() {
    return true;
  }

  void onDeleteOrderClicked() async {
    final displayMode = _displayMode();
    if (displayMode is OrderDetailsDisplayMode$Owner) {
      final order = _orderDetails().requireValue.$2;
      if (order.orderState != OrderState.created) {
        return;
      }
      try {
        _isWorkingNotifier().state = true;
        await _orderRepository()
            .deleteOrderById(orderId: order.orderId)
            .onValue((e) => _sideEffect().add(const OrderDetailsSideEffect$NavBack()));
      } finally {
        _isWorkingNotifier().state = false;
      }
    }
  }

  void onEditClicked() async {
    final displayMode = _displayMode();
    if (displayMode is OrderDetailsDisplayMode$Owner) {
      final order = _orderDetails().requireValue.$2;
      if (order.orderState != OrderState.created) {
        return;
      }
      _sideEffect().add(OrderDetailsSideEffect$NavToEditOrder(orderId: order.orderId));
    }
  }
}
