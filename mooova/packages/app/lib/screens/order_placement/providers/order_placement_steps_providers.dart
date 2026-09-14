part of '_order_placement_providers.dart';

final stepsProvider = NotifierProvider<OrderPlacementStepsNotifier, (int index, List<OrderPlacementStep> steps)>(
  name: '$_name.stepsProvider',
  dependencies: _scope.dependencies,
  () => OrderPlacementStepsNotifier(),
);

class OrderPlacementStepsNotifier extends Notifier<(int index, List<OrderPlacementStep> steps)> {
  @override
  (int, List<OrderPlacementStep>) build() {
    final initialOrderModel = ref.watch(orderPlacementProvider).value;
    if (initialOrderModel == null) return (0, []);
    return (0, initialOrderModel.$1.asSteps);
  }

  late final _initialOrderModel = () => ref.read(orderPlacementProvider);
  late final _isDuplicateMode = () => ref.read(orderPlacementProvider.notifier).isDuplicateMode;
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _orderPlacementRepository = () => ref.read(orderPlacementRepositoryProvider);
  late final _orderSize = () => ref.read(orderSizeProvider.notifier);
  late final _description = () => ref.read(descriptionProvider.notifier);
  late final _finalPrice = () => ref.read(finalPriceProvider.notifier);
  late final _images = () => ref.read(imagesProvider.notifier);
  late final _numOfWorkersRequested = () => ref.read(numOfWorkersRequestedProvider.notifier);
  late final _addresses = () => ref.read(addressesProvider.notifier);
  late final _isWorking = () => ref.read(isWorkingProvider.notifier);
  late final _productCondition = () => ref.read(productConditionProvider.notifier);
  late final _pickUpTimes = () => ref.read(pickUpTimesProvider.notifier);
  late final _recommendations = () => ref.read(recommendationsProvider.notifier);
  late final _recommendation = () => ref.read(recommendationProvider);

  void onNavBackClicked() async {
    if (state.$2.getAtOrNull(state.$1 - 1) != null) {
      state = (state.$1 - 1, state.$2);
    } else {
      _sideEffect().add(const OrderPlacementSideEffect$NavBack());
    }
  }

  void onContinueClicked() async {
    final currentStep = state.$2[state.$1];
    final nextStepIndex = state.$1 + 1;
    switch (currentStep) {
      case OrderPlacementStep.inventory:
      case OrderPlacementStep.imagesMove:
      case OrderPlacementStep.imagesGiveAway:
      case OrderPlacementStep.price:
        state = (nextStepIndex, state.$2);
        break;
      case OrderPlacementStep.address:
        await _onContinueToPrice(nextStepIndex);
        break;
      case OrderPlacementStep.review:
        await _onFinishReview();
        break;
    }
  }

  Future<void> _onContinueToPrice(int nextStepIndex) async {
    try {
      _isWorking().state = true;
      final addresses = _addresses().state.toList();
      final pickUpAddress = addresses.removeAt(pickUpAddressKey);
      final deliveryAddresses = addresses.where((e) => e.isFilled).toList();
      await _orderPlacementRepository()
          .getPriceRecommendation(pickUpAddress: pickUpAddress, deliveryAddresses: deliveryAddresses)
          .onValue((e) {
        _recommendations().state = e.associateBy((e) => e.orderSize);
        _finalPrice().state = _recommendations().state[_orderSize().state]!.estimatedPrice;
        state = (nextStepIndex, state.$2);
      });
    } finally {
      _isWorking().state = false;
    }
  }

  Future<void> _onFinishReview() async {
    try {
      _isWorking().state = true;
      final addresses = _addresses().state.toList();
      final pickUpAddress = addresses.removeAt(pickUpAddressKey);
      final deliveryAddresses = addresses.where((e) => e.isFilled).toList();
      await _orderPlacementRepository()
          .createOrUpdateOrder(
            orderId: _isDuplicateMode() ? null : _initialOrderModel().value!.$2?.orderId,
            orderType: _initialOrderModel().value!.$1,
            orderSize: _orderSize().state,
            description: _description().state,
            finalPrice: _finalPrice().state,
            adminFee: _recommendation()?.adminFee,
            currency: _recommendation()?.currency,
            images: _images().state.map((e) => e.$2).mapNotNull((e) => e).toList(),
            numOfWorkersRequested: _numOfWorkersRequested().state,
            productCondition: _productCondition().state,
            pickUpAddress: pickUpAddress,
            deliveryAddresses: deliveryAddresses,
            pickUpTimes: _pickUpTimes().state,
          )
          .onValue((e) => _sideEffect().add(const OrderPlacementSideEffect$NavBack()));
    } finally {
      _isWorking().state = false;
    }
  }
}
