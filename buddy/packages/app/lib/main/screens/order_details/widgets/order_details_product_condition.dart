import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/product_condition_type.dart';

class OrderDetailsProductCondition extends StatelessWidget {
  final ProductCondition productCondition;

  const OrderDetailsProductCondition({
    super.key,
    required this.productCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.HowCondition.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            productCondition.let((it) {
              switch (it) {
                case ProductCondition.acceptable:
                  return LocaleKeys.Fair.tr();
                case ProductCondition.good:
                  return LocaleKeys.Good.tr();
                case ProductCondition.veryGood:
                  return LocaleKeys.VeryGood.tr();
              }
            }),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
