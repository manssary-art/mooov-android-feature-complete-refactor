part of '_order_worker_selection_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<OrderWorkerSelectionSideEffect>.broadcast(),
).scoped(_scope);

sealed class OrderWorkerSelectionSideEffect {}

class OrderWorkerSelectionSideEffect$NavBack implements OrderWorkerSelectionSideEffect {
  const OrderWorkerSelectionSideEffect$NavBack();
}

class OrderWorkerSelectionSideEffect$NavToPayment implements OrderWorkerSelectionSideEffect {
  final String candidateId;
  final DateTime time;

  const OrderWorkerSelectionSideEffect$NavToPayment(this.candidateId, this.time);
}
