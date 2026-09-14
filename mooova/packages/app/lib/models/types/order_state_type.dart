enum OrderState {
  created,
  assigned,
  delivered,
  completed,
  expired,
  refunded,
}

extension OrderStateTypeStringExt on String {
  OrderState? toOrderStateOrNull() {
    switch (this) {
      case _OrderStateValue.assigned:
        return OrderState.assigned;
      case _OrderStateValue.completed:
        return OrderState.completed;
      case _OrderStateValue.deleted:
        // We don't care about deleted orders
        return null;
      case _OrderStateValue.delivered:
        return OrderState.delivered;
      case _OrderStateValue.expired:
        return OrderState.expired;
      case _OrderStateValue.created:
        return OrderState.created;
      case _OrderStateValue.refunded:
        return OrderState.refunded;
      default:
        return null;
    }
  }
}

extension StringOrderStateTypeExt on OrderState {
  String toDtoString() {
    switch (this) {
      case OrderState.assigned:
        return _OrderStateValue.assigned;
      case OrderState.completed:
        return _OrderStateValue.completed;
      case OrderState.delivered:
        return _OrderStateValue.delivered;
      case OrderState.expired:
        return _OrderStateValue.expired;
      case OrderState.created:
        return _OrderStateValue.created;
      case OrderState.refunded:
        return _OrderStateValue.refunded;
    }
  }
}

final class _OrderStateValue {
  static const created = "NEW";
  static const assigned = "ASSIGNED";
  static const delivered = "DELIVERED";
  static const completed = "COMPLETED";
  static const deleted = "DELETED";
  static const expired = "EXPIRED";
  static const refunded = "REFUNDED";
}
