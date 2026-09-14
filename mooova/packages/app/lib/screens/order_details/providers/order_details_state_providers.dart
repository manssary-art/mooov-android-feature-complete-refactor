part of '_order_details_providers.dart';

final isWorkingProvider = StateProvider<bool>(
  name: '$_name.isWorkingProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);

final displayModeProvider = Provider(
  name: '$_name.displayModeProvider',
  dependencies: _scope.dependencies,
  (ref) {
    final orderDetails = ref.watch(orderDetailsProvider).valueOrNull;
    final user = orderDetails?.$1;
    final order = orderDetails?.$2;
    if (user == null || order == null) {
      return OrderDetailsDisplayMode$Visitor(null);
    } else if (user.userId == order.owner.userId) {
      return OrderDetailsDisplayMode$Owner();
    } else if (user.userId == order.worker?.userId) {
      return OrderDetailsDisplayMode$WorkerAssigned(order.finalPickupTime!);
    } else if (order.candidates?.entries.firstOrNull((e) => e.key.userId == user.userId) != null) {
      final candidate = order.candidates?.entries.firstOrNull((e) => e.key.userId == user.userId);
      return OrderDetailsDisplayMode$WorkerApplied(candidate!.value);
    } else {
      return OrderDetailsDisplayMode$Visitor(user.role);
    }
  },
).scoped(_scope);
