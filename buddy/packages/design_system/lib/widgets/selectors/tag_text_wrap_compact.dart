import 'package:flutter/material.dart';

import 'wrap_builder.dart';

class TagTextWrapCompact extends StatelessWidget {
  final List<String> items;
  final WrapAlignment alignment;
  final Color? color;

  const TagTextWrapCompact({
    super.key,
    required this.items,
    this.color,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return WrapBuilder(
      count: items.length,
      alignment: alignment,
      spacing: 6,
      runSpacing: 6,
      builder: (context, index, selected) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(4.0),
          ),
          constraints: const BoxConstraints(
            minWidth: 60,
          ),
          child: Text(
            items[index],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
          ),
        );
      },
    );
  }
}
