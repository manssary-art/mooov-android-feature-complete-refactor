import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/locale_keys.gen.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemWorkerRefunded extends StatelessWidget {
  final ActivitiesOrderItem$Worker$Refunded item;
  final VoidCallback onWorkerEmailSupportClicked;

  const ActivitiesItemWorkerRefunded({
    super.key,
    required this.item,
    required this.onWorkerEmailSupportClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ActivitiesItemContentProfile(
          user: item.order.owner,
        ),
        Container(height: 16),
        ActivitiesItemContentImages(
          orderType: item.order.orderType,
          pickUpImage: item.order.pickupImages?.first ?? '',
          deliveredImage: item.order.deliveredImages?.first ?? '',
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: onWorkerEmailSupportClicked,
          child: Text(LocaleKeys.Support.tr()),
        ),
      ],
    );
  }
}
