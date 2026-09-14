import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../../../../models/types/order_state_type.dart';
import '../../../../models/types/order_type.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/riverpod_ext.dart';
import '../ext/order_model_ext.dart';
import '../models/activities_tab.dart';
import '../widgets/content/activities_screen_content.dart';

class ActivitiesScreenPreview extends HookWidget with PreviewMixin {
  ActivitiesScreenPreview({
    super.key,
  });

  @override
  String get name => 'ActivitiesScreen';

  @override
  Widget build(BuildContext context) {
    final perspective = usePreviewOptions('Perspective', ['Owner', 'Worker']);
    final orderTypes = OrderType.values.associateBy((e) => e.name);
    final orderType = usePreviewOptions('OrderType', orderTypes.keys.toList());
    final order = fakeOrderModel().copyWith(orderType: () => orderTypes[orderType]!);
    final userId = perspective == 'Owner' ? order.owner.userId : order.worker!.userId;
    final orders = [
      order.copyWith(orderState: () => OrderState.assigned, pickupImages: () => null, deliveredImages: () => null),
      order.copyWith(orderState: () => OrderState.assigned, deliveredImages: () => null),
      order.copyWith(orderState: () => OrderState.delivered),
      order.copyWith(orderState: () => OrderState.completed),
      order.copyWith(orderState: () => OrderState.refunded),
      order.copyWith(orderState: () => OrderState.expired),
    ];

    final items = orders.mapNotNull((e) => e.toActivitiesOrderItemOrNull(userId)).toList();
    final tab = useState(ActivitiesTab.active);
    return ActivitiesScreenContentLoaded(
      selectedTab: tab.value,
      onTabClicked: tab.onValueChanged,
      items: items,
      isRefreshing: false,
      onPullToRefresh: () {},
      onItemClicked: (_) {},
      onOwnerIncreasePriceClicked: (_) {},
      onOwnerEmailSupportClicked: (_) {},
      onOwnerSelectCandidateClicked: (_) {},
      onOwnerPhoneCallWorkerClicked: (_) {},
      onOwnerPhoneSmsWorkerClicked: (_) {},
      onOwnerDeliveryDoneClicked: (_) {},
      onOwnerRateOrderClicked: (_) {},
      onOwnerRenewOrderClicked: (_) {},
      onWorkerPhoneCallOwnerClicked: (_) {},
      onWorkerPhoneSmsOwnerClicked: (_) {},
      onWorkerUploadPickedUpImageClicked: (_) {},
      onWorkerUploadDeliveredImageClicked: (_) {},
      onWorkerCancelAndRefundClicked: (_) {},
      onWorkerDeliveryDoneClicked: (_) {},
      onWorkerEmailSupportClicked: (_) {},
    );
  }
}
