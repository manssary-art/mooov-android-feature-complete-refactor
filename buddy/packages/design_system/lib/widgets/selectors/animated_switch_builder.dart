import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../gestures/clickable.dart';
import 'animated_selector.dart';

class AnimatedSwitchBuilder extends HookWidget {
  final int selectedIndex;
  final int count;
  final Widget Function(BuildContext context, int index) builder;
  final void Function(int index) onItemClicked;

  const AnimatedSwitchBuilder({
    super.key,
    required this.builder,
    required this.count,
    required this.selectedIndex,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
              width: 4,
            ),
          ),
          child: AnimatedSelector(
            axis: Axis.horizontal,
            selectedIndex: selectedIndex,
            itemSize: AnimatedSelectorItemSize.equals,
            indicatorDecoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).primaryColor,
            ),
            children: List.generate(
              count,
              (i) => Clickable(
                onTap: () => onItemClicked(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Builder(
                    builder: (context) => builder(context, i),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
