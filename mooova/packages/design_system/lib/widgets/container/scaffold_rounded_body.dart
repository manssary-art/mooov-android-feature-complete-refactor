import 'package:flutter/material.dart';

class ScaffoldRoundedBody extends StatelessWidget {
  static const kBorderRadius = 32.0;

  final Widget child;
  final Color? color;
  final BorderRadius borderRadius;

  const ScaffoldRoundedBody({
    Key? key,
    this.color,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(kBorderRadius),
      topRight: Radius.circular(kBorderRadius),
    ),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          color: color,
          width: double.infinity,
          height: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
