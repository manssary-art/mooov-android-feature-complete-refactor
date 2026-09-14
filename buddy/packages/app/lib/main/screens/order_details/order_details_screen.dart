import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'providers/_order_details_providers.dart';
import 'widgets/content/order_details_screen_content.dart';

class OrderDetailsScreen extends HookConsumerWidget {
  final String orderId;
  final VoidCallback onNavBack;
  final Function(List<String> images, int index) onNavToImagesViewer;
  final Function(String orderId) onNavToEditOrder;
  final Function() onNavToAuth;
  final Function() onNavToWorkerApplicationForm;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.onNavBack,
    required this.onNavToImagesViewer,
    required this.onNavToEditOrder,
    required this.onNavToAuth,
    required this.onNavToWorkerApplicationForm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        orderDetailsProvider.overrideWith(() => OrderDetailsNotifier(orderId)),
      ],
      child: _OrderDetailsScreen(
        onNavBack: onNavBack,
        onNavToImagesViewer: onNavToImagesViewer,
        onNavToEditOrder: onNavToEditOrder,
        onNavToAuth: onNavToAuth,
        onNavToWorkerApplicationForm: onNavToWorkerApplicationForm,
      ),
    );
  }
}

class _OrderDetailsScreen extends HookConsumerWidget {
  final VoidCallback onNavBack;
  final Function(List<String> images, int index) onNavToImagesViewer;
  final Function(String orderId) onNavToEditOrder;
  final Function() onNavToAuth;
  final Function() onNavToWorkerApplicationForm;

  const _OrderDetailsScreen({
    super.key,
    required this.onNavBack,
    required this.onNavToImagesViewer,
    required this.onNavToEditOrder,
    required this.onNavToAuth,
    required this.onNavToWorkerApplicationForm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialNotifier = ref.watch(orderDetailsProvider.notifier);
    final initial = ref.watch(orderDetailsProvider);
    final sideEffect = ref.watch(sideEffectProvider);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case OrderDetailsSideEffect$NavBack():
            onNavBack();
            break;
          case OrderDetailsSideEffect$ShareUrl():
            Share.share(effect.url);
            break;
          case OrderDetailsSideEffect$NavToEditOrder():
            onNavToEditOrder(effect.orderId);
            break;
          case OrderDetailsSideEffect$NavToAuthentication():
            onNavToAuth();
            break;
          case OrderDetailsSideEffect$NavToWorkerApplicationForm():
            onNavToWorkerApplicationForm();
            break;
        }
      }).cancel,
      [sideEffect],
    );

    if (initial.isLoading && !initial.hasValue) {
      return OrderDetailsScreenContentLoading(
        onNavBackClicked: initialNotifier.onNavBackClicked,
      );
    }

    if (initial.hasError) {
      return OrderDetailsScreenContentError(
        onNavBackClicked: initialNotifier.onNavBackClicked,
      );
    }

    final translatedDescriptionNotifier = ref.watch(translatedDescriptionProvider.notifier);
    final workerNotifier = ref.watch(workerProvider.notifier);
    final ownerNotifier = ref.watch(ownerProvider.notifier);
    final isWorking = ref.watch(isWorkingProvider);
    final userLocation = ref.watch(userLocationProvider);
    final translatedDescription = ref.watch(translatedDescriptionProvider);
    final displayMode = ref.watch(displayModeProvider);
    return OrderDetailsScreenContentLoaded(
      order: initial.requireValue.$2,
      isWorking: isWorking,
      userLocation: userLocation,
      translatedDescription: translatedDescription,
      displayMode: displayMode,
      onNavBackClicked: initialNotifier.onNavBackClicked,
      onOrderImageClicked: onNavToImagesViewer,
      onShareClicked: initialNotifier.onShareClicked,
      onEditClicked: ownerNotifier.onEditClicked,
      onTranslateClicked: () => translatedDescriptionNotifier.onTranslateClicked(context.locale.languageCode),
      onDeleteOrderClicked: ownerNotifier.onDeleteOrderClicked,
      onApplyToOrderClicked: workerNotifier.onApplyToOrderClicked,
      onWithdrawApplyToOrderClicked: workerNotifier.onWithdrawApplyToOrderClicked,
    );
  }
}
