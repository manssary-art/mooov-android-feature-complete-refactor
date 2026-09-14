enum OrderSize {
  s,
  m,
  l,
}

extension DtoOrderTypeExt on String {
  OrderSize? toOrderSizeOrNull() {
    switch (this) {
      case _OrderSizeValue.s:
        return OrderSize.s;
      case _OrderSizeValue.m:
        return OrderSize.m;
      case _OrderSizeValue.l:
        return OrderSize.l;
      default:
        return null;
    }
  }
}

extension OrderSizeTypeStringExt on OrderSize {
  String toDtoString() {
    switch (this) {
      case OrderSize.s:
        return _OrderSizeValue.s;
      case OrderSize.m:
        return _OrderSizeValue.m;
      case OrderSize.l:
        return _OrderSizeValue.l;
    }
  }
}

final class _OrderSizeValue {
  static const s = "S";
  static const m = "M";
  static const l = "L";
}
