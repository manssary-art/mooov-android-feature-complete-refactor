import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../../../../models/types/order_type.dart';
import '../../../../models/types/user_role_type.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/hooks/flutter_hooks.dart';
import '../models/order_details_display_mode.dart';
import '../widgets/content/order_details_screen_content.dart';

class OrderDetailsScreenPreview extends HookWidget with PreviewMixin {
  OrderDetailsScreenPreview({
    super.key,
  });

  @override
  String get name => 'OrderDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final fakeOrder = fakeOrderModel();
    final displayModes = {
      'Visitor UnAuthed': OrderDetailsDisplayMode$Visitor(null),
      'Visitor Authed Worker': OrderDetailsDisplayMode$Visitor(UserRole.worker),
      'Visitor Authed User': OrderDetailsDisplayMode$Visitor(UserRole.user),
      'Owner': OrderDetailsDisplayMode$Owner(),
      'Worker Applied': OrderDetailsDisplayMode$WorkerApplied([fakeOrder.pickupTime![0]]),
      'Worker Assigned': OrderDetailsDisplayMode$WorkerAssigned(fakeOrder.pickupTime![0]),
    };
    final perspective = usePreviewOptions('Perspective', displayModes.keys.toList());
    final displayMode = displayModes[perspective]!;
    final orderTypes = OrderType.values.associateBy((e) => e.name);
    final orderType = usePreviewOptions('OrderType', orderTypes.keys.toList());
    final order = fakeOrder.copyWith(orderType: () => orderTypes[orderType]!);

    return OrderDetailsScreenContentLoaded(
      order: useUpdateState(order),
      isWorking: useUpdateState(false),
      userLocation: useUpdateState(null),
      translatedDescription: useUpdateState(null),
      displayMode: useUpdateState(displayMode),
      onNavBackClicked: () {},
      onOrderImageClicked: (_, __) {},
      onShareClicked: () {},
      onEditClicked: () {},
      onTranslateClicked: () => () {},
      onApplyToOrderClicked: (_) {},
      onWithdrawApplyToOrderClicked: () {},
      onDeleteOrderClicked: () {},
    );
  }
}
