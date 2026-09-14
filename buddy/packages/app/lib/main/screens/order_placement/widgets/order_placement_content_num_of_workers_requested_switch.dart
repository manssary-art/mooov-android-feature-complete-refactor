import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class OrderPlacementContentNumOfWorkersRequestedSwitch extends StatelessWidget {
  final List<int> items;
  final int selected;
  final void Function(int value) onItemClicked;

  const OrderPlacementContentNumOfWorkersRequestedSwitch({
    super.key,
    this.items = const [1, 2],
    required this.selected,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    const items = [1, 2];
    final selectedIndex = items.indexOf(selected);
    return AnimatedSwitchBuilder(
      selectedIndex: selectedIndex,
      count: items.length,
      onItemClicked: (i) => onItemClicked(items[i]),
      builder: (context, index) {
        return SizedBox(
          width: 80,
          height: 32,
          child: let(() {
            if (index == 0) {
              return Assets.images.iconMoverOneGray.image(
                color: items[index] == 1 ? ColorName.neutral80 : Theme.of(context).primaryColor,
              );
            } else {
              return Assets.images.iconMoverTwoGray.image(
                color: items[index] != 1 ? ColorName.neutral80 : Theme.of(context).primaryColor,
              );
            }
          }),
        );
      },
    );
  }
}
