import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class ActivitiesContentEmpty extends StatelessWidget {
  const ActivitiesContentEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.imageWomenCouch.image(
            width: 196,
            height: 196,
          ),
          Container(height: 16),
          Text(
            LocaleKeys.EmptyDiscoverText.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
