import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';
import 'activities_item_content_images.dart';
import 'activities_item_content_profile.dart';

class ActivitiesItemWorkerAssigned extends StatelessWidget {
  final ActivitiesOrderItem$Worker$Assigned item;
  final VoidCallback onWorkerPhoneCallOwnerClicked;
  final VoidCallback onWorkerPhoneSmsOwnerClicked;
  final VoidCallback onWorkerUploadPickedUpImageClicked;
  final VoidCallback onWorkerCancelAndRefundClicked;

  const ActivitiesItemWorkerAssigned({
    super.key,
    required this.item,
    required this.onWorkerPhoneCallOwnerClicked,
    required this.onWorkerPhoneSmsOwnerClicked,
    required this.onWorkerUploadPickedUpImageClicked,
    required this.onWorkerCancelAndRefundClicked,
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
          onPickUpImageClicked: onWorkerUploadPickedUpImageClicked,
        ),
        const SizedBox(height: 16),
        Text(
          LocaleKeys.TakePickupPhoto.tr(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Clickable(
          onTap: onWorkerCancelAndRefundClicked,
          child: Text(
            LocaleKeys.CancelButtonMooover.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.underline,
                  color: ColorName.error,
                  decorationColor: ColorName.error,
                ),
          ),
        ),
      ],
    );
  }
}
