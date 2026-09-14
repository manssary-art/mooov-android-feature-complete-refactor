part of '_order_details_providers.dart';

final workerProvider = NotifierProvider<OrderDetailsWorkerNotifier, bool>(
  name: '$_name.workerProvider',
  dependencies: _scope.dependencies,
  () => OrderDetailsWorkerNotifier(),
).scoped(_scope);

class OrderDetailsWorkerNotifier extends Notifier<bool> {
  late final _orderCandidateRepository = () => ref.read(orderCandidateRepositoryProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _displayMode = () => ref.read(displayModeProvider);
  late final _orderDetails = () => ref.read(orderDetailsProvider);
  late final _isWorkingNotifier = () => ref.read(isWorkingProvider.notifier);

  @override
  bool build() {
    return true;
  }

  void onApplyToOrderClicked(
    List<DateTime> value,
  ) async {
    final displayMode = _displayMode();
    if (displayMode is OrderDetailsDisplayMode$Visitor && displayMode.role == null) {
      _sideEffect().add(const OrderDetailsSideEffect$NavToAuthentication());
    } else if (displayMode is OrderDetailsDisplayMode$Visitor && displayMode.role == UserRole.user) {
      _sideEffect().add(const OrderDetailsSideEffect$NavToWorkerApplicationForm());
    } else if (displayMode is OrderDetailsDisplayMode$Visitor && displayMode.role == UserRole.worker) {
      try {
        _isWorkingNotifier().state = true;
        final orderDetails = _orderDetails().requireValue;
        await _orderCandidateRepository().addWorkerApplicationForOrder(
          orderId: orderDetails.$2.orderId,
          workerId: orderDetails.$1!.userId,
          pickupTimes: value,
        );
      } finally {
        _isWorkingNotifier().state = false;
      }
    }
  }

  void onWithdrawApplyToOrderClicked() async {
    final displayMode = _displayMode();
    if (displayMode is OrderDetailsDisplayMode$WorkerApplied) {
      try {
        _isWorkingNotifier().state = true;
        final orderDetails = _orderDetails().requireValue;
        await _orderCandidateRepository().deleteWorkerApplicationForOrder(
          orderId: orderDetails.$2.orderId,
          workerId: orderDetails.$1!.userId,
        );
      } finally {
        _isWorkingNotifier().state = false;
      }
    }
  }
}
