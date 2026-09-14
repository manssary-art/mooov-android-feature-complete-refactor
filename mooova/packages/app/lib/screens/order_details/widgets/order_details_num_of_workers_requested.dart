import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class OrderDetailsNumOfWorkersRequested extends StatelessWidget {
  final int count;

  const OrderDetailsNumOfWorkersRequested({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final count = this.count ?? 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.NeedHowManyPeople.tr(namedArgs: {
            '#1': count.toString(),
          }),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (count > 1 ? Assets.images.iconMoverTwoGray : Assets.images.iconMoverOneGray).image(
              width: 24,
              height: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
