import 'package:flutter/material.dart';

class OrderRatingStars extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;
  final double size;

  const OrderRatingStars({
    super.key,
    required this.rating,
    required this.onChanged,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final filled = starValue <= rating;
        return IconButton(
          iconSize: size,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          constraints: const BoxConstraints(),
          icon: Icon(
            filled ? Icons.star : Icons.star_border,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => onChanged(starValue),
        );
      }),
    );
  }
}
