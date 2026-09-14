import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../gestures/clickable.dart';

class WrapBuilder extends StatelessWidget {
  final int count;
  final List<int>? selectedIndexes;
  final ValueSetter<int>? onItemClicked;
  final WrapAlignment alignment;
  final Widget Function(BuildContext context, int index, bool selected) builder;
  final double spacing;
  final double runSpacing;

  const WrapBuilder({
    super.key,
    required this.count,
    required this.builder,
    this.selectedIndexes,
    this.onItemClicked,
    this.alignment = WrapAlignment.start,
    this.spacing = 12,
    this.runSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: alignment,
      children: [
        for (int i = 0; i < count; i++) ...[
          Clickable(
            onTap: onItemClicked?.let((fun) => () => fun(i)),
            child: builder(
              context,
              i,
              selectedIndexes != null && selectedIndexes!.contains(i),
            ),
          ),
        ],
      ],
    );
  }
}
