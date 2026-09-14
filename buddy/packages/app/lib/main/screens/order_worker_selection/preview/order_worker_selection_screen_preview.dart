import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:preview/preview.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../widgets/content/order_worker_selection_screen_content.dart';

class OrderWorkerSelectionScreenPreview extends HookWidget with PreviewMixin {
  OrderWorkerSelectionScreenPreview({
    super.key,
  });

  @override
  String get name => 'OrderWorkerSelectionScreen';

  @override
  Widget build(BuildContext context) {
    final order = useMemoized(() => fakeOrderModel());
    final selected = useState<(String userId, DateTime time)?>(null);
    return OrderWorkerSelectionScreenContentLoaded(
      candidates: order.candidates!.entries.map((entry) => (entry.key, entry.value)).toList(),
      selected: selected.value,
      onNavBackClicked: () {},
      onUserProfileImageClicked: (userId) {},
      onUserVehicleImageClicked: (userId) {},
      onTimeClicked: (userId, time) {
        if (selected.value == (userId, time)) {
          selected.value = null;
        } else {
          selected.value = (userId, time);
        }
      },
      onSubmitClicked: () {},
    );
  }
}
