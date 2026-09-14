import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/order_address_model.dart';
import '../models/activities_order_item.dart';
import 'activities_item_content_body.dart';
import 'activities_item_content_progress.dart';
import 'activities_item_owner_assigned.dart';
import 'activities_item_owner_completed.dart';
import 'activities_item_owner_created.dart';
import 'activities_item_owner_delivered.dart';
import 'activities_item_owner_expired.dart';
import 'activities_item_owner_picked_up.dart';
import 'activities_item_owner_refunded.dart';
import 'activities_item_owner_select_candidate.dart';
import 'activities_item_worker_applied.dart';
import 'activities_item_worker_assigned.dart';
import 'activities_item_worker_completed.dart';
import 'activities_item_worker_delivered.dart';
import 'activities_item_worker_picked_up.dart';
import 'activities_item_worker_refunded.dart';

class ActivitiesItemContent extends StatelessWidget {
  final ActivitiesOrderItem item;

  /// Common Actions

  final VoidCallback onItemClicked;
  final ValueSetter<String> onCopyAddressClicked;
  final ValueSetter<OrderAddressModel> onNavigateClicked;

  /// Owner actions

  final VoidCallback onOwnerEmailSupportClicked;
  final VoidCallback onOwnerIncreasePriceClicked;
  final VoidCallback onOwnerSelectCandidateClicked;
  final VoidCallback onOwnerPhoneCallWorkerClicked;
  final VoidCallback onOwnerPhoneSmsWorkerClicked;
  final VoidCallback onOwnerDeliveryDoneClicked;
  final VoidCallback onOwnerRateOrderClicked;
  final VoidCallback onOwnerRenewOrderClicked;

  /// Worker actions

  final VoidCallback onWorkerPhoneCallOwnerClicked;
  final VoidCallback onWorkerPhoneSmsOwnerClicked;
  final VoidCallback onWorkerUploadPickedUpImageClicked;
  final VoidCallback onWorkerUploadDeliveredImageClicked;
  final VoidCallback onWorkerCancelAndRefundClicked;
  final VoidCallback onWorkerDeliveryDoneClicked;
  final VoidCallback onWorkerEmailSupportClicked;

  const ActivitiesItemContent({
    super.key,
    required this.item,
    required this.onItemClicked,
    required this.onCopyAddressClicked,
    required this.onNavigateClicked,
    required this.onOwnerIncreasePriceClicked,
    required this.onOwnerEmailSupportClicked,
    required this.onOwnerSelectCandidateClicked,
    required this.onOwnerPhoneCallWorkerClicked,
    required this.onOwnerPhoneSmsWorkerClicked,
    required this.onOwnerDeliveryDoneClicked,
    required this.onOwnerRateOrderClicked,
    required this.onOwnerRenewOrderClicked,
    required this.onWorkerPhoneCallOwnerClicked,
    required this.onWorkerPhoneSmsOwnerClicked,
    required this.onWorkerUploadPickedUpImageClicked,
    required this.onWorkerUploadDeliveredImageClicked,
    required this.onWorkerCancelAndRefundClicked,
    required this.onWorkerDeliveryDoneClicked,
    required this.onWorkerEmailSupportClicked,
  });

  @override
  Widget build(BuildContext context) {
    final item = this.item;

    switch (item) {
      /// Owner states

      case ActivitiesOrderItem$Owner$Created():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.WaitingForResponse.tr(),
            progress: 0.25,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerCreated(
            item: item,
            onOwnerIncreasePriceClicked: onOwnerIncreasePriceClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$SelectCandidate():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.SelectAMooover.tr(),
            progress: 0.35,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerSelectCandidate(
            item: item,
            onOwnerSelectCandidateClicked: onOwnerSelectCandidateClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$Assigned():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.MoooverOnTheWay.tr(),
            progress: 0.50,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerAssigned(
            item: item,
            onOwnerPhoneCallWorkerClicked: onOwnerPhoneCallWorkerClicked,
            onOwnerPhoneSmsWorkerClicked: onOwnerPhoneSmsWorkerClicked,
            onOwnerEmailSupportClicked: onOwnerEmailSupportClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$PickedUp():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.StatusRefunded.tr(),
            progress: 0.60,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerPickedUp(
            item: item,
            onOwnerPhoneCallWorkerClicked: onOwnerPhoneCallWorkerClicked,
            onOwnerPhoneSmsWorkerClicked: onOwnerPhoneSmsWorkerClicked,
            onOwnerEmailSupportClicked: onOwnerEmailSupportClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$Delivered():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.ConfirmAndPay.tr(),
            progress: 0.75,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerDelivered(
            item: item,
            onOwnerPhoneCallWorkerClicked: onOwnerPhoneCallWorkerClicked,
            onOwnerPhoneSmsWorkerClicked: onOwnerPhoneSmsWorkerClicked,
            onOwnerDeliveryDoneClicked: onOwnerDeliveryDoneClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$Completed():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.Completed.tr(),
            progress: 1.00,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerCompleted(
            item: item,
            onOwnerEmailSupportClicked: onOwnerEmailSupportClicked,
            onOwnerRateOrderClicked: onOwnerRateOrderClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$Refunded():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.StatusRefunded.tr(),
            progress: 1.00,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerRefunded(
            item: item,
            onOwnerRateOrderClicked: onOwnerRateOrderClicked,
            onOwnerRenewOrderClicked: onOwnerRenewOrderClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Owner$Expired():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.owner(
            title: LocaleKeys.StatusRefunded.tr(),
            progress: 1.00,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
          ),
          footer: ActivitiesItemOwnerExpired(
            item: item,
            onOwnerEmailSupportClicked: onOwnerEmailSupportClicked,
            onOwnerRenewOrderClicked: onOwnerRenewOrderClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );

      /// Worker states

      case ActivitiesOrderItem$Worker$Applied():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.worker(
            title: LocaleKeys.WaitingForResponse.tr(),
            progress: 0.25,
          ),
          body: ActivitiesItemBody(
            order: item.order,
          ),
          footer: ActivitiesItemWorkerApplied(
            item: item,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Worker$Assigned():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.worker(
            title: LocaleKeys.YouChoosen.tr(),
            progress: 0.50,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
            onNavigateClicked: onNavigateClicked,
          ),
          footer: ActivitiesItemWorkerAssigned(
            item: item,
            onWorkerPhoneCallOwnerClicked: onWorkerPhoneCallOwnerClicked,
            onWorkerPhoneSmsOwnerClicked: onWorkerPhoneSmsOwnerClicked,
            onWorkerUploadPickedUpImageClicked: onWorkerUploadPickedUpImageClicked,
            onWorkerCancelAndRefundClicked: onWorkerCancelAndRefundClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Worker$PickedUp():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.worker(
            title: LocaleKeys.NowDeliverTo.tr(),
            progress: 0.60,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
            onNavigateClicked: onNavigateClicked,
          ),
          footer: ActivitiesItemWorkerPickedUp(
            item: item,
            onWorkerPhoneCallOwnerClicked: onWorkerPhoneCallOwnerClicked,
            onWorkerPhoneSmsOwnerClicked: onWorkerPhoneSmsOwnerClicked,
            onWorkerUploadDeliveredImageClicked: onWorkerUploadDeliveredImageClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Worker$Delivered():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.worker(
            title: LocaleKeys.EveryThingDone.tr(),
            progress: 0.75,
          ),
          body: ActivitiesItemBody(
            order: item.order,
            onCopyAddressClicked: onCopyAddressClicked,
            onNavigateClicked: onNavigateClicked,
          ),
          footer: ActivitiesItemWorkerDelivered(
            item: item,
            onWorkerPhoneCallOwnerClicked: onWorkerPhoneCallOwnerClicked,
            onWorkerPhoneSmsOwnerClicked: onWorkerPhoneSmsOwnerClicked,
            onWorkerDeliveryDoneClicked: onWorkerDeliveryDoneClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Worker$Completed():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.worker(
            title: LocaleKeys.Completed.tr(),
            progress: 1.00,
          ),
          body: ActivitiesItemBody(
            order: item.order,
          ),
          footer: ActivitiesItemWorkerCompleted(
            item: item,
            onWorkerEmailSupportClicked: onWorkerEmailSupportClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
      case ActivitiesOrderItem$Worker$Refunded():
        return _ActivitiesItemContent(
          header: ActivitiesItemContentProgress.worker(
            title: LocaleKeys.StatusRefunded.tr(),
            progress: 1.00,
          ),
          body: ActivitiesItemBody(
            order: item.order,
          ),
          footer: ActivitiesItemWorkerRefunded(
            item: item,
            onWorkerEmailSupportClicked: onWorkerEmailSupportClicked,
          ),
          onHeaderBodyClicked: onItemClicked,
        );
    }
  }
}

class _ActivitiesItemContent extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget? footer;
  final VoidCallback onHeaderBodyClicked;

  const _ActivitiesItemContent({
    required this.header,
    required this.body,
    required this.footer,
    required this.onHeaderBodyClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Clickable(
            onTap: onHeaderBodyClicked,
            child: header,
          ),
          const Divider(
            height: 40,
          ),
          Clickable(
            onTap: onHeaderBodyClicked,
            child: body,
          ),
          if (footer != null) ...[
            const Divider(
              height: 40,
            ),
            footer!,
          ]
        ],
      ),
    );
  }
}
