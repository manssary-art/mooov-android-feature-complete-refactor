import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemOwnerRefunded extends StatelessWidget {
  final ActivitiesOrderItem$Owner$Refunded item;
  final VoidCallback onOwnerRateOrderClicked;
  final VoidCallback onOwnerRenewOrderClicked;

  const ActivitiesItemOwnerRefunded({
    super.key,
    required this.item,
    required this.onOwnerRateOrderClicked,
    required this.onOwnerRenewOrderClicked,
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
            Flexible(
              flex: 4,
              child: OutlinedButton(
                onPressed: onOwnerRateOrderClicked,
                child: Text(LocaleKeys.Rate.tr()),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 7,
              child: FilledButton(
                onPressed: onOwnerRenewOrderClicked,
                child: Text(LocaleKeys.RenewOrderButton.tr()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
