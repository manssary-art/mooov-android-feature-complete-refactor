import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/order_size_type.dart';
import '../../../../models/types/product_condition_type.dart';

class OrderPlacementContentOrderSizeSwitch extends StatelessWidget {
  final List<OrderSize> items;
  final OrderSize selected;
  final void Function(OrderSize value) onItemClicked;

  const OrderPlacementContentOrderSizeSwitch({
    super.key,
    this.items = OrderSize.values,
    required this.selected,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final size in OrderSize.values) ...[
          Expanded(
            child: Clickable(
              onTap: () => onItemClicked(size),
              child: Container(
                decoration: BoxDecoration(
                  color: selected == size ? ColorName.neutral80 : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size == OrderSize.s ? 4.5 : 4),
                  child: let(() {
                    switch (size) {
                      case OrderSize.s:
                        return Assets.images.imageOrderSizeSmall;
                      case OrderSize.m:
                        return Assets.images.imageOrderSizeMedium;
                      case OrderSize.l:
                        return Assets.images.imageOrderSizeLarge;
                    }
                  }).image(fit: BoxFit.cover),
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}
