import 'package:flutter/material.dart';

import '../../extensions/material_ext.dart';

class Clickable extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget child;
  final ClickableIndicator indicator;

  const Clickable({
    super.key,
    this.indicator = ClickableIndicator.ripple,
    this.onTap,
    this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    switch (indicator) {
      case ClickableIndicator.ripple:
        return InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        );
      case ClickableIndicator.nothing:
        return InkWell(
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          overlayColor: Colors.transparent.asMSP,
          splashColor: Colors.transparent,
          onTap: onTap,
          onLongPress: onLongPress,
          child: child,
        );
    }
  }
}

enum ClickableIndicator {
  ripple,
  nothing,
}
