part 'string_iban_ext.dart';

extension StringExt on String {
  /// Returns a progression that goes over the same range in the opposite direction with the same step.
  String reversed() {
    var res = "";
    for (int i = length; i >= 0; --i) {
      res = this[i];
    }
    return res;
  }

  /// Returns the value of this number as an [int]
  int toInt() => int.parse(this);

  /// Returns the value of this number as an [int] or null if can not be parsed.
  int? toIntOrNull() {
    return int.tryParse(this);
  }

  /// Returns the value of this number as an [double]
  double toDouble() => double.parse(this!);

  /// Returns the value of this number as an [double] or null if can not be parsed.
  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  /// Returns true if 'this' is "true", otherwise - false
  bool toBoolean() => toLowerCase() == "true";
}

extension StringNullableExt on String? {
  /// Returns `true` if strings are equals without matching case
  bool equalsOther(String? other, {bool ignoreCase = false}) {
    if (this == null && other == null) return true;
    if (this == null && other != null) return false;
    if (this != null && other == null) return false;
    if (ignoreCase) {
      return this?.toLowerCase() == other?.toLowerCase();
    } else {
      return this == other;
    }
  }

  /// Returns `true` if string contains another without matching case
  bool containsOther(String other, {bool ignoreCase = false}) {
    if (ignoreCase) {
      return this?.toLowerCase().contains(other.toLowerCase()) ?? false;
    } else {
      return this?.contains(other) ?? false;
    }
  }
}

extension EmailStringExt on String {
  bool get isValidEmail => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(this);
}
