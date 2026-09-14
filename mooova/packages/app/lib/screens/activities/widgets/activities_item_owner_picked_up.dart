import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemOwnerPickedUp extends StatelessWidget {
  final ActivitiesOrderItem$Owner$PickedUp item;
  final VoidCallback onOwnerPhoneCallWorkerClicked;
  final VoidCallback onOwnerPhoneSmsWorkerClicked;
  final VoidCallback onOwnerEmailSupportClicked;

  const ActivitiesItemOwnerPickedUp({
    super.key,
    required this.item,
    required this.onOwnerPhoneCallWorkerClicked,
    required this.onOwnerPhoneSmsWorkerClicked,
    required this.onOwnerEmailSupportClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ActivitiesItemContentProfile(
          user: item.order.worker!,
          onPhoneCallClicked: onOwnerPhoneCallWorkerClicked,
          onPhoneSmsClicked: onOwnerPhoneSmsWorkerClicked,
        ),
        const SizedBox(height: 16),
        ActivitiesItemContentImages(
          orderType: item.order.orderType,
          pickUpImage: item.order.pickupImages?.first ?? '',
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: onOwnerEmailSupportClicked,
          child: Text(LocaleKeys.Support.tr()),
        ),
      ],
    );
  }
}
