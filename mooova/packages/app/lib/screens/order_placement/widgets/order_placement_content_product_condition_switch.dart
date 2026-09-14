import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/product_condition_type.dart';

class OrderPlacementContentProductConditionSwitch extends StatelessWidget {
  final List<ProductCondition> items;
  final ProductCondition selected;
  final void Function(ProductCondition value) onItemClicked;

  const OrderPlacementContentProductConditionSwitch({
    super.key,
    this.items = ProductCondition.values,
    required this.selected,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitchBuilder(
      selectedIndex: items.indexOf(selected),
      count: items.length,
      onItemClicked: (i) => onItemClicked(items[i]),
      builder: (context, index) {
        return Text(
          items[index].let((value) {
            switch (value) {
              case ProductCondition.acceptable:
                return LocaleKeys.Fair.tr();
              case ProductCondition.good:
                return LocaleKeys.Good.tr();
              case ProductCondition.veryGood:
                return LocaleKeys.VeryGood.tr();
            }
          }),
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
