part of '_order_worker_selection_providers.dart';

final selectedPickupTimeProvider =
    NotifierProvider<OrderWorkerSelectionSelectedPickUpTimeNotifier, (String userId, DateTime time)?>(
  name: '$_name.selectedPickupTimeProvider',
  dependencies: _scope.dependencies,
  () => OrderWorkerSelectionSelectedPickUpTimeNotifier(),
).scoped(_scope);

class OrderWorkerSelectionSelectedPickUpTimeNotifier extends Notifier<(String userId, DateTime time)?> {
  @override
  (String userId, DateTime time)? build() {
    return null;
  }

  void onPickUpTimeClicked(
    String userId,
    DateTime time,
  ) async {
    state = (userId, time);
  }
}
