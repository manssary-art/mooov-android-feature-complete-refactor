import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/ext/riverpod_ext.dart';
import '../../core/hooks/flutter_hooks.dart';
import 'providers/_activities_providers.dart';
import 'widgets/content/activities_screen_content.dart';

class ActivitiesScreen extends HookConsumerWidget {
  final void Function(String orderId) onNavToOrderDetails;
  final void Function(String orderId) onNavToWorkerSelection;

  const ActivitiesScreen({
    super.key,
    required this.onNavToOrderDetails,
    required this.onNavToWorkerSelection,
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
          case ActivitiesSideEffect$OpenUrl():
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
          onOwnerIncreasePriceClicked: (_) {},
          onOwnerEmailSupportClicked: (_) {},
          onOwnerSelectCandidateClicked: onNavToWorkerSelection,
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
      },
    );
  }
}
