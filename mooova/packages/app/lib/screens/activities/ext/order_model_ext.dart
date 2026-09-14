import 'package:core/core.dart';

import '../../../../models/order_model.dart';
import '../../../../models/types/order_state_type.dart';
import '../models/activities_order_item.dart';

extension OrderModelActivitiesOrderItem on OrderModel {
  ActivitiesOrderItem? toActivitiesOrderItemOrNull(String userId) {
    if (owner.userId == userId) {
      switch (orderState) {
        case OrderState.created:
          if (candidates?.isNotEmpty == true) {
            return ActivitiesOrderItem$Owner$SelectCandidate(order: this);
          } else {
            const increasePriceMap = {
              'SEK': 50.0,
              'NOK': 50.0,
              'DKK': 50.0,
              'EUR': 5.0,
            };

            final amount = increasePriceMap[currency.code] ?? 5.0;
            return ActivitiesOrderItem$Owner$Created(order: this, priceIncreaseAmount: amount);
          }
        case OrderState.assigned:
          if (pickupImages?.isNotEmpty == true) {
            return ActivitiesOrderItem$Owner$PickedUp(order: this);
          } else {
            return ActivitiesOrderItem$Owner$Assigned(order: this);
          }
        case OrderState.delivered:
          return ActivitiesOrderItem$Owner$Delivered(order: this);
        case OrderState.completed:
          return ActivitiesOrderItem$Owner$Completed(order: this);
        case OrderState.expired:
          return ActivitiesOrderItem$Owner$Expired(order: this);
        case OrderState.refunded:
          return ActivitiesOrderItem$Owner$Refunded(order: this);
      }
    }

    if (worker?.userId == userId) {
      switch (orderState) {
        case OrderState.created:
          // Should never happen
          return null;
        case OrderState.assigned:
          if (pickupImages?.isNotEmpty == true) {
            return ActivitiesOrderItem$Worker$PickedUp(order: this);
          } else {
            return ActivitiesOrderItem$Worker$Assigned(order: this);
          }
        case OrderState.delivered:
          return ActivitiesOrderItem$Worker$Delivered(order: this);
        case OrderState.completed:
          return ActivitiesOrderItem$Worker$Completed(order: this);
        case OrderState.expired:
          // We don't display expired orders for workers
          return null;
        case OrderState.refunded:
          return ActivitiesOrderItem$Worker$Refunded(order: this);
      }
    }

    if (candidates?.entries.any((e) => e.key.userId == userId) == true) {
      switch (orderState) {
        case OrderState.created:
          return ActivitiesOrderItem$Worker$Applied(order: this);
        case OrderState.assigned:
        case OrderState.delivered:
        case OrderState.completed:
        case OrderState.expired:
        case OrderState.refunded:
          // We don't display other states for candidates
          return null;
      }
    }

    // Something is not right, we should cover everything
    resultOf(() => throw Exception('Unable to handle order for current user\nuserId=$userId order=$this'));
    return null;
  }
}
