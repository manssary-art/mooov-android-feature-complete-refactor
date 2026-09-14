import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'wrap_builder.dart';

class TagTextPicker extends StatelessWidget {
  final List<String> items;
  final List<int>? selectedIndexes;
  final ValueSetter<int>? onItemClicked;
  final WrapAlignment alignment;

  const TagTextPicker({
    super.key,
    required this.items,
    this.selectedIndexes,
    this.onItemClicked,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return WrapBuilder(
      count: items.length,
      selectedIndexes: selectedIndexes,
      onItemClicked: onItemClicked,
      alignment: alignment,
      builder: (context, index, selected) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: let(() {
              if (selected) {
                return Theme.of(context).colorScheme.primary;
              } else {
                return Theme.of(context).colorScheme.surface;
              }
            }),
            borderRadius: BorderRadius.circular(8.0),
          ),
          constraints: const BoxConstraints(
            minWidth: 80,
          ),
          child: Text(
            items[index],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: let(() {
                if (selected) {
                  return Theme.of(context).textTheme.bodyLarge?.color;
                } else {
                  return Theme.of(context).disabledColor;
                }
              }),
            ),
          ),
        );
      },
    );
  }
}
