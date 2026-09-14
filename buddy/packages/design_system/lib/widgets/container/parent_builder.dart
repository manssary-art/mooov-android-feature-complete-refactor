import 'package:flutter/material.dart';

class ParentBuilder extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, Widget child) builder;

  const ParentBuilder({
    super.key,
    required this.builder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
