import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/hooks/flutter_hooks.dart';
import 'providers/_order_worker_selection_providers.dart';
import 'widgets/content/order_worker_selection_screen_content.dart';

class OrderWorkerSelectionScreen extends HookConsumerWidget {
  final String orderId;
  final VoidCallback onNavBack;
  final Function(List<String> images, int index) onNavToImagesViewer;
  final Function(String candidateId, DateTime time) onNavToPayment;

  const OrderWorkerSelectionScreen({
    super.key,
    required this.orderId,
    required this.onNavBack,
    required this.onNavToImagesViewer,
    required this.onNavToPayment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        orderWorkerSelectionProvider.overrideWith(() => OrderWorkerSelectionNotifier(orderId)),
      ],
      child: _OrderWorkerSelectionScreen(
        onNavBack: onNavBack,
        onNavToImagesViewer: onNavToImagesViewer,
        onNavToPayment: onNavToPayment,
      ),
    );
  }
}

class _OrderWorkerSelectionScreen extends HookConsumerWidget {
  final VoidCallback onNavBack;
  final Function(List<String> images, int index) onNavToImagesViewer;
  final Function(String candidateId, DateTime time) onNavToPayment;

  const _OrderWorkerSelectionScreen({
    super.key,
    required this.onNavBack,
    required this.onNavToImagesViewer,
    required this.onNavToPayment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialNotifier = ref.watch(orderWorkerSelectionProvider.notifier);
    final initial = ref.watch(orderWorkerSelectionProvider);
    final sideEffect = ref.watch(sideEffectProvider);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case OrderWorkerSelectionSideEffect$NavBack():
            onNavBack();
            break;
          case OrderWorkerSelectionSideEffect$NavToPayment():
            onNavToPayment(effect.candidateId, effect.time);
            break;
        }
      }).cancel,
      [sideEffect],
    );

    if (initial.isLoading && !initial.hasValue) {
      return OrderWorkerSelectionScreenContentLoading(
        onNavBackClicked: initialNotifier.onNavBackClicked,
      );
    }

    if (initial.hasError) {
      return OrderWorkerSelectionScreenContentError(
        error: initial.error,
        onNavBackClicked: initialNotifier.onNavBackClicked,
        onTryAgainClicked: initialNotifier.onTryAgainClicked,
      );
    }

    final candidates = initial.requireValue;
    final selected = ref.watch(selectedPickupTimeProvider);
    final selectedNotifier = ref.watch(selectedPickupTimeProvider.notifier);
    return HookBuilder(builder: (context) {
      return OrderWorkerSelectionScreenContentLoaded(
        candidates: useUpdateState(candidates),
        selected: useUpdateState(selected),
        onNavBackClicked: initialNotifier.onNavBackClicked,
        onUserProfileImageClicked: useCallback((userId) {
          final user = candidates.firstOrNull((e) => e.$1.userId == userId)?.$1;
          if (user != null && user.image != null) {
            onNavToImagesViewer([user.image!], 0);
          }
        }, [candidates]),
        onUserVehicleImageClicked: useCallback((userId) {
          final user = candidates.firstOrNull((e) => e.$1.userId == userId)?.$1;
          if (user != null && user.workerInfo?.vehiclesImagesUrls?.isNotEmpty == true) {
            onNavToImagesViewer(user.workerInfo!.vehiclesImagesUrls!, 0);
          }
        }, [candidates]),
        onTimeClicked: selectedNotifier.onPickUpTimeClicked,
        onSubmitClicked: initialNotifier.onSubmitClicked,
      );
    });
  }
}
