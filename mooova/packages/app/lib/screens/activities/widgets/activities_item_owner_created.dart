import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';

class ActivitiesItemOwnerCreated extends StatelessWidget {
  final ActivitiesOrderItem$Owner$Created item;
  final VoidCallback onOwnerIncreasePriceClicked;

  const ActivitiesItemOwnerCreated({
    super.key,
    required this.item,
    required this.onOwnerIncreasePriceClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.IncreasePrice.tr(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: onOwnerIncreasePriceClicked,
          child: Text('+ ${item.order.currency.format(item.priceIncreaseAmount)}'),
        ),
      ],
    );
  }
}
