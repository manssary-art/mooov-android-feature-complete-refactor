enum OrderType {
  move,
  buyForMe,
  giveAway,
  fetchForMe,
  recycle,
}

extension DtoOrderTypeExt on String {
  OrderType? toOrderTypeOrNull() {
    switch (this) {
      case _OrderStateValue.buyForMe:
        return OrderType.buyForMe;
      case _OrderStateValue.giveAway:
        return OrderType.giveAway;
      case _OrderStateValue.move:
        return OrderType.move;
      case _OrderStateValue.fetchForMe:
        return OrderType.fetchForMe;
      case _OrderStateValue.recycle:
        return OrderType.recycle;
      default:
        return null;
    }
  }
}

extension OrderTypeDtoStringExt on OrderType {
  String toDtoString() {
    switch (this) {
      case OrderType.buyForMe:
        return _OrderStateValue.buyForMe;
      case OrderType.giveAway:
        return _OrderStateValue.giveAway;
      case OrderType.move:
        return _OrderStateValue.move;
      case OrderType.fetchForMe:
        return _OrderStateValue.fetchForMe;
      case OrderType.recycle:
        return _OrderStateValue.recycle;
    }
  }
}

final class _OrderStateValue {
  static const move = "MOVE";
  static const buyForMe = "BUY_FOR_ME";
  static const giveAway = "GIVE_AWAY";
  static const fetchForMe = "FETCH_FOR_ME";
  static const recycle = "RECYCLE";
}
