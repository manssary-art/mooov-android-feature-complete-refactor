import '../../../../models/types/order_type.dart';

sealed class OrderPlacementMode {}

class OrderPlacementMode$New extends OrderPlacementMode {
  final OrderType orderType;

  OrderPlacementMode$New(this.orderType);
}

class OrderPlacementMode$Edit extends OrderPlacementMode {
  final String orderId;
  final bool duplicate;

  OrderPlacementMode$Edit(this.orderId, this.duplicate);
}
