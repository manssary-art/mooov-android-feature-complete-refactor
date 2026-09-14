import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemWorkerDelivered extends StatelessWidget {
  final ActivitiesOrderItem$Worker$Delivered item;
  final VoidCallback onWorkerPhoneCallOwnerClicked;
  final VoidCallback onWorkerPhoneSmsOwnerClicked;
  final VoidCallback onWorkerDeliveryDoneClicked;

  const ActivitiesItemWorkerDelivered({
    super.key,
    required this.item,
    required this.onWorkerPhoneCallOwnerClicked,
    required this.onWorkerPhoneSmsOwnerClicked,
    required this.onWorkerDeliveryDoneClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ActivitiesItemContentProfile(
          user: item.order.owner,
          onPhoneCallClicked: onWorkerPhoneCallOwnerClicked,
          onPhoneSmsClicked: onWorkerPhoneSmsOwnerClicked,
        ),
        const SizedBox(height: 16),
        ActivitiesItemContentImages(
          orderType: item.order.orderType,
          pickUpImage: item.order.pickupImages?.first ?? '',
          deliveredImage: item.order.deliveredImages?.first ?? '',
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: onWorkerDeliveryDoneClicked,
          child: Text(LocaleKeys.EveryThingDone.tr()),
        ),
      ],
    );
  }
}
