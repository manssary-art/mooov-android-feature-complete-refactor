import 'package:flutter/material.dart';

class RatingTile extends StatelessWidget {
  final double value;
  final int maxValue;
  final Color? color;
  final double size;

  const RatingTile({
    super.key,
    required this.value,
    this.maxValue = 5,
    this.color,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).primaryColor;
    final stars = List.generate(maxValue, (index) {
      final diff = (value - index);
      if (diff >= 1) return Icons.star;
      if (diff >= 0.5) return Icons.star_half_outlined;
      return Icons.star_outline;
    });

    return Row(
      children: [
        for (final star in stars) ...[
          Icon(
            star,
            color: color,
            size: size,
          ),
        ]
      ],
    );
  }
}
