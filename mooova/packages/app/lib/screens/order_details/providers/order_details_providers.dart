part of '_order_details_providers.dart';

final orderDetailsProvider = StreamNotifierProvider<OrderDetailsNotifier, (UserModel? user, OrderModel order)>(
  name: '$_name.orderDetailsProvider',
  dependencies: _scope.dependencies,
  () => throw UnimplementedError(),
).scoped(_scope);

class OrderDetailsNotifier extends StreamNotifier<(UserModel? user, OrderModel order)> {
  final String orderId;

  OrderDetailsNotifier(this.orderId);

  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _deepLinksRepository = () => ref.read(deepLinksRepositoryProvider);

  @override
  Stream<(UserModel? user, OrderModel order)> build() async* {
    final userRepository = ref.watch(userRepositoryProvider);
    final orderRepository = ref.watch(orderRepositoryProvider);
    final startWithUserResult = await userRepository.getUserOrNull();
    final startWithOderResult = await orderRepository.getOrderById(
      orderId: orderId,
    );

    yield* Rx.combineLatest2(
      userRepository.onUserChanged.cast<UserModel?>().startWith(startWithUserResult.asValue!.value),
      orderRepository.onOrderChanged.where((e) => e.orderId == orderId).startWith(startWithOderResult.asValue!.value),
      (user, order) => (user, order),
    );
  }

  void onNavBackClicked() async {
    _sideEffect().add(const OrderDetailsSideEffect$NavBack());
  }

  void onShareClicked() async {
    await _deepLinksRepository()
        .getDeepLinkForOrderId(orderId: orderId)
        .onValue((e) => _sideEffect().add(OrderDetailsSideEffect$ShareUrl(url: e)));
  }
}