import '../../../../models/types/order_state_type.dart';
import '../models/activities_order_item.dart';

extension ActivitiesOrderItemExt on ActivitiesOrderItem {
  bool get isCompleted => switch (order.orderState) {
        OrderState.created => false,
        OrderState.assigned => false,
        OrderState.delivered => false,
        OrderState.completed => true,
        OrderState.expired => true,
        OrderState.refunded => true,
      };
}
