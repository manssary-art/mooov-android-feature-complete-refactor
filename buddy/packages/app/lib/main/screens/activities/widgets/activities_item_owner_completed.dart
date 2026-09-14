import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/locale_keys.gen.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemOwnerCompleted extends StatelessWidget {
  final ActivitiesOrderItem$Owner$Completed item;
  final VoidCallback onOwnerEmailSupportClicked;
  final VoidCallback onOwnerRateOrderClicked;

  const ActivitiesItemOwnerCompleted({
    super.key,
    required this.item,
    required this.onOwnerEmailSupportClicked,
    required this.onOwnerRateOrderClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ActivitiesItemContentProfile(
          user: item.order.worker!,
        ),
        const SizedBox(height: 16),
        ActivitiesItemContentImages(
          orderType: item.order.orderType,
          pickUpImage: item.order.pickupImages?.first ?? '',
          deliveredImage: item.order.deliveredImages?.first ?? '',
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onOwnerEmailSupportClicked,
                child: Text(LocaleKeys.Support.tr()),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: onOwnerRateOrderClicked,
                child: Text(LocaleKeys.Rate.tr()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
