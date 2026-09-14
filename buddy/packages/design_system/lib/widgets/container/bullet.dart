import 'package:flutter/material.dart';

class Bullet extends StatelessWidget {
  final Color? color;
  final double? size;

  const Bullet({
    Key? key,
    this.size = 4,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
