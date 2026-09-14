import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemWorkerPickedUp extends StatelessWidget {
  final ActivitiesOrderItem$Worker$PickedUp item;
  final VoidCallback onWorkerPhoneCallOwnerClicked;
  final VoidCallback onWorkerPhoneSmsOwnerClicked;
  final VoidCallback onWorkerUploadDeliveredImageClicked;

  const ActivitiesItemWorkerPickedUp({
    super.key,
    required this.item,
    required this.onWorkerPhoneCallOwnerClicked,
    required this.onWorkerPhoneSmsOwnerClicked,
    required this.onWorkerUploadDeliveredImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          onDeliveredImageClicked: onWorkerUploadDeliveredImageClicked,
        ),
        const SizedBox(height: 16),
        Text(
          LocaleKeys.TakeDeliveredPhoto.tr(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
