part of '_order_payment_providers.dart';

final orderPaymentProvider = AsyncNotifierProvider<OrderPaymentNotifier, OrderPaymentModel>(
  name: '$_name.OrderPaymentProvider',
  dependencies: _scope.dependencies,
  () => throw UnimplementedError(),
).scoped(_scope);

class OrderPaymentNotifier extends AsyncNotifier<OrderPaymentModel> {
  final OrderPaymentScreenParams params;

  OrderPaymentNotifier(this.params);

  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);
  late final _placePaymentRepository = () => ref.read(placePaymentRepositoryProvider);

  @override
  FutureOr<OrderPaymentModel> build() async {
    final orderRepository = ref.watch(orderRepositoryProvider);
    final savedPaymentMethodRepository = ref.watch(savedPaymentMethodRepositoryProvider);
    final placePaymentRepository = ref.watch(placePaymentRepositoryProvider);
    final userRepository = ref.watch(userRepositoryProvider);

    var order = state.valueOrNull?.order;
    order ??= (await orderRepository.getOrderById(orderId: params.orderId)).asValue!.value;

    var user = state.valueOrNull?.user;
    user ??= (await userRepository.getUser()).asValue!.value;

    var savedCard = state.valueOrNull?.methods
        .mapNotNull((e) => e is AvailablePaymentMethod$SavedCard ? e.info : null)
        .firstOrNull();
    savedCard ??= (await savedPaymentMethodRepository.getSavedCard()).asValue?.value.firstOrNull();

    final promoCode = ref.watch(promoCodeProvider);
    await ref.debounce(Duration(milliseconds: state.hasValue ? 500 : 0));

    final cardIntent = (await placePaymentRepository.createIntent(
      orderId: params.orderId,
      workerId: params.candidateId,
      promoCode: promoCode,
      finalPickUpTime: params.time,
      type: PaymentMethodType.card,
    ))
        .asValue!
        .value;

    final klarnaIntent = (await placePaymentRepository.createIntent(
      orderId: params.orderId,
      workerId: params.candidateId,
      promoCode: promoCode,
      finalPickUpTime: params.time,
      type: PaymentMethodType.klarna,
    ))
        .asValue!
        .value;

    final methods = <AvailablePaymentMethod>[];
    if (savedCard != null) {
      methods.add(AvailablePaymentMethod$SavedCard(cardIntent, savedCard));
    }
    methods.add(AvailablePaymentMethod$Card(cardIntent));
    methods.add(AvailablePaymentMethod$Klarna(klarnaIntent));

    return OrderPaymentModel(
      order: order,
      methods: methods,
      user: user,
    );
  }

  void onNavBackClicked() async {
    _sideEffect().add(const OrderPaymentSideEffect$NavBack(false));
  }

  void onTryAgainClicked() async {
    if (state.hasError) {
      ref.invalidateSelf();
    }
  }

  void onPaymentMethodClicked(
    AvailablePaymentMethod method,
  ) async {
    try {
      _isWorkingNotifier().state = true;
      switch (method) {
        case AvailablePaymentMethod$Card():
          _sideEffect().add(OrderPaymentSideEffect$NavToCardPayment(method.intent));
          break;
        case AvailablePaymentMethod$Klarna():
          _placePaymentRepository().placeKlarnaPayment(intent: method.intent).onValue((value) {
            _sideEffect().add(const OrderPaymentSideEffect$NavBack(true));
          });
          break;
        case AvailablePaymentMethod$SavedCard():
          _placePaymentRepository().placeSavedCardPayment(id: method.info.id, intent: method.intent).onValue((value) {
            _sideEffect().add(const OrderPaymentSideEffect$NavBack(true));
          });
          break;
      }
    } finally {
      _isWorkingNotifier().state = false;
    }
  }

  void onSubmitCardPaymentClicked() async {
    try {
      _isWorkingNotifier().state = true;
      final cardMethod = state.requireValue.methods.whereType<AvailablePaymentMethod$Card>().first;
      final monthStr = ref.read(cardExpirationMonthProvider) ?? '';
      final yearStr = ref.read(cardExpirationYearProvider) ?? '';
      final result = await _placePaymentRepository().placeCardPayment(
        intent: cardMethod.intent,
        number: ref.read(cardNumberProvider) ?? '',
        expirationMonth: int.parse(monthStr),
        expirationYear: int.parse(yearStr) + 2000,
        cvc: ref.read(cardCVCProvider) ?? '',
        save: ref.read(saveCardProvider),
      );
      result.onValue((value) => _sideEffect().add(const OrderPaymentSideEffect$NavBack(true)));
    } finally {
      _isWorkingNotifier().state = false;
    }
  }
}
