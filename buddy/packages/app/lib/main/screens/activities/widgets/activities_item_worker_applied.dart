import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemWorkerApplied extends StatelessWidget {
  final ActivitiesOrderItem$Worker$Applied item;

  const ActivitiesItemWorkerApplied({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ActivitiesItemContentProfile(
          user: item.order.owner,
        ),
        Container(height: 16),
        FilledButton(
          onPressed: null,
          child: Text(LocaleKeys.WaitingForResponse.tr()),
        ),
      ],
    );
  }
}
