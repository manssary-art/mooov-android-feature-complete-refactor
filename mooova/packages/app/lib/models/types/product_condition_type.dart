enum ProductCondition {
  acceptable,
  good,
  veryGood,
}

extension ProductConditionTypeStringExt on String {
  ProductCondition? toProductConditionTypeOrNull() {
    switch (this) {
      case _ProductCondition.acceptable:
        return ProductCondition.acceptable;
      case _ProductCondition.good:
        return ProductCondition.good;
      case _ProductCondition.veryGood:
        return ProductCondition.veryGood;
      default:
        return null;
    }
  }
}

extension StringProductConditionTypeExt on ProductCondition {
  String? toDtoString() {
    switch (this) {
      case ProductCondition.acceptable:
        return _ProductCondition.acceptable;
      case ProductCondition.good:
        return _ProductCondition.good;
      case ProductCondition.veryGood:
        return _ProductCondition.veryGood;
    }
  }
}

final class _ProductCondition {
  static const acceptable = "ACCEPTABLE";
  static const good = "GOOD";
  static const veryGood = "VERY_GOOD";
}
