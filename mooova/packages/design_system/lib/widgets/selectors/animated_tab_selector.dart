import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../design_system.dart';

class AnimatedTabSelector extends HookWidget {
  final int selectedIndex;
  final List<String> items;
  final void Function(int index) onItemClicked;

  const AnimatedTabSelector({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: borderRadius,
      ),
      child: AnimatedSelector(
        axis: Axis.horizontal,
        selectedIndex: selectedIndex,
        itemSize: AnimatedSelectorItemSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        indicatorDecoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Theme.of(context).primaryColor,
        ),
        children: items
            .mapIndexed(
              (i, e) => Clickable(
                onTap: () => onItemClicked(i),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints.expand(),
                  child: Text(
                    e,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
