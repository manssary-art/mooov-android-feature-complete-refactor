import 'package:flutter/material.dart';

extension MaterialAnyT<T> on T {
  MaterialStateProperty<T> get asMSP => MaterialStateProperty.all(this);
}
