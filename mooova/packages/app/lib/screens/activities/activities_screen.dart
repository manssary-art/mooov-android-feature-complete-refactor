import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/ext/riverpod_ext.dart';
import '../../core/hooks/flutter_hooks.dart';
import '../../main/router/routes/utilities/image_picker_route.dart';
import 'providers/_activities_providers.dart';
import 'widgets/activities_dialog_worker_refund.dart';
import 'widgets/content/activities_screen_content.dart';

class ActivitiesScreen extends HookConsumerWidget {
  final void Function(String orderId) onNavToOrderDetails;
  final void Function(String orderId) onNavToWorkerSelection;
  final void Function(String orderId) onNavToOrderRating;
  final void Function(String orderId) onNavToOrderPlacementDuplicate;

  const ActivitiesScreen({
    super.key,
    required this.onNavToOrderDetails,
    required this.onNavToWorkerSelection,
    required this.onNavToOrderRating,
    required this.onNavToOrderPlacementDuplicate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = ref.watch(activitiesProvider);
    final initialNotifier = ref.watch(activitiesProvider.notifier);
    final sideEffect = ref.watch(sideEffectProvider);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case ActivitiesSideEffect$NavToProfile():
            break;
          case ActivitiesSideEffect$OpenUrl(:final url):
            try {
              await launchUrl(Uri.parse(url));
            } catch (_) {}
            break;
          case ActivitiesSideEffect$NavToImagePicker(:final orderId, :final type):
            final file = await showImagePickerBottomModalSheet(context: context);
            if (file != null) {
              await initialNotifier.onImagePicked(orderId: orderId, type: type, file: file);
            }
            break;
        }
      }).cancel,
      [sideEffect],
    );

    useEffect(() {
      initialNotifier.onPullToRefresh();
      return null;
    }, [initialNotifier]);

    final selectedTabNotifier = ref.watch(selectedTabProvider.notifier);
    final selectedTab = ref.watch(selectedTabProvider);

    if (initial.isLoading && !initial.hasValue) {
      return ActivitiesScreenContentLoading(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onValueChanged,
      );
    }

    if (initial.hasError) {
      return ActivitiesScreenContentError(
        selectedTab: selectedTab,
        onTabClicked: selectedTabNotifier.onValueChanged,
        onTryAgainClicked: initialNotifier.onPullToRefresh,
      );
    }

    return HookBuilder(
      builder: (context) {
        return ActivitiesScreenContentLoaded(
          selectedTab: useUpdateState(selectedTab),
          onTabClicked: selectedTabNotifier.onValueChanged,
          items: useUpdateState(initial.valueOrNull ?? []),
          isRefreshing: useUpdateState(initial.isRefreshing),
          onPullToRefresh: initialNotifier.onPullToRefresh,
          onItemClicked: onNavToOrderDetails,
          onOwnerIncreasePriceClicked: initialNotifier.onOwnerIncreasePriceClicked,
          onOwnerEmailSupportClicked: (_) {},
          onOwnerSelectCandidateClicked: onNavToWorkerSelection,
          onOwnerPhoneCallWorkerClicked: initialNotifier.onOwnerPhoneCallWorkerClicked,
          onOwnerPhoneSmsWorkerClicked: initialNotifier.onOwnerPhoneSmsWorkerClicked,
          onOwnerDeliveryDoneClicked: initialNotifier.onOwnerDeliveryDoneClicked,
          onOwnerRateOrderClicked: onNavToOrderRating,
          onOwnerRenewOrderClicked: onNavToOrderPlacementDuplicate,
          onWorkerPhoneCallOwnerClicked: initialNotifier.onWorkerPhoneCallOwnerClicked,
          onWorkerPhoneSmsOwnerClicked: initialNotifier.onWorkerPhoneSmsOwnerClicked,
          onWorkerUploadPickedUpImageClicked: initialNotifier.onWorkerUploadPickedUpImageClicked,
          onWorkerUploadDeliveredImageClicked: initialNotifier.onWorkerUploadDeliveredImageClicked,
          onWorkerCancelAndRefundClicked: (orderId) => showDialog(
            context: context,
            builder: (context) => ActivitiesDialogWorkerRefund(
              onConfirm: () => initialNotifier.onWorkerCancelAndRefundClicked(orderId),
            ),
          ),
          onWorkerDeliveryDoneClicked: (_) {},
          onWorkerEmailSupportClicked: (_) {},
        );
      },
    );
  }
}
