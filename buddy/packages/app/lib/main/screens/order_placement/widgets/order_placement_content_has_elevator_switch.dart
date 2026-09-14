import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class OrderPlacementContentHasElevatorSwitch extends StatelessWidget {
  final bool selected;
  final void Function(bool value) onItemClicked;

  const OrderPlacementContentHasElevatorSwitch({
    super.key,
    required this.selected,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    const items = [true, false];
    final selectedIndex = items.indexOf(selected);
    return AnimatedSwitchBuilder(
      selectedIndex: selectedIndex,
      count: items.length,
      onItemClicked: (i) => onItemClicked(items[i]),
      builder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            index == 0 ? LocaleKeys.Elevator.tr() : LocaleKeys.Stairs.tr(),
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
