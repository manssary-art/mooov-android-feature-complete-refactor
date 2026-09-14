import 'package:flutter/services.dart';

abstract class FilteringTextInputFormatters {
  static final notDigits = FilteringTextInputFormatter.allow(RegExp(r'[^0-9]'));
}
