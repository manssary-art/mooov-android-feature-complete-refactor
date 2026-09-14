import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/order_address_model.dart';
import '../../../models/places_details_model.dart';
import '../../../models/types/order_type.dart';
import '../../core/riverpod_ext.dart';
import 'models/order_placement_address.dart';
import 'models/order_placement_mode.dart';
import 'models/order_placement_steps.dart';
import 'providers/_order_placement_providers.dart';
import 'widgets/content/order_placement_screen_content.dart';
import 'widgets/order_placement_content_header.dart';
import 'widgets/step_address/order_placement_step_address.dart';
import 'widgets/step_images/order_placement_step_images.dart';
import 'widgets/step_images_give_away/order_placement_step_images_give_away.dart';
import 'widgets/step_price/order_placement_step_price.dart';
import 'widgets/step_review/order_placement_step_review.dart';

class OrderPlacementScreen extends StatelessWidget {
  final OrderPlacementMode mode;
  final void Function() onNavBack;
  final Future<XFile?> Function() onNavToImagePicker;
  final Future<PlacesDetailsModel?> Function() onNavToAddressPicker;

  const OrderPlacementScreen({
    super.key,
    required this.mode,
    required this.onNavBack,
    required this.onNavToImagePicker,
    required this.onNavToAddressPicker,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        orderPlacementProvider.overrideWith(() => OrderPlacementNotifier(mode)),
      ],
      child: _OrderPlacementScreen(
        onNavBack: onNavBack,
        onNavToImagePicker: onNavToImagePicker,
        onNavToAddressPicker: onNavToAddressPicker,
      ),
    );
  }
}

class _OrderPlacementScreen extends HookConsumerWidget {
  final void Function() onNavBack;
  final Future<XFile?> Function() onNavToImagePicker;
  final Future<PlacesDetailsModel?> Function() onNavToAddressPicker;

  const _OrderPlacementScreen({
    super.key,
    required this.onNavBack,
    required this.onNavToImagePicker,
    required this.onNavToAddressPicker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = ref.watch(orderPlacementProvider);
    final sideEffect = ref.watch(sideEffectProvider);
    final (stepIndex, steps) = ref.watch(stepsProvider);
    final isWorking = ref.watch(isWorkingProvider);
    final imagesNotifier = ref.watch(imagesProvider.notifier);
    final addressesNotifier = ref.watch(addressesProvider.notifier);
    final stepsNotifier = ref.watch(stepsProvider.notifier);
    final descriptionNotifier = ref.watch(descriptionProvider.notifier);
    final productConditionNotifier =
        ref.watch(productConditionProvider.notifier);
    final orderSizeNotifier = ref.watch(orderSizeProvider.notifier);
    final pickUpTimesNotifier = ref.watch(pickUpTimesProvider.notifier);
    final numOfWorkersRequestedNotifier =
        ref.watch(numOfWorkersRequestedProvider.notifier);
    final finalPriceNotifier = ref.watch(finalPriceProvider.notifier);
    final isTermAcceptedNotifier = ref.watch(isTermAcceptedProvider.notifier);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case OrderPlacementSideEffect$NavBack():
            onNavBack();
            break;
          case OrderPlacementSideEffect$NavToAddressPicker():
            final address = await onNavToAddressPicker();
            if (address != null) {
              addressesNotifier.onAddressPicked(effect.key, address);
            }
            break;
          case OrderPlacementSideEffect$NavToImagePicker():
            final image = await onNavToImagePicker();
            if (image != null) {
              imagesNotifier.onImagePicked(effect.key, image);
            }
            break;
        }
      }).cancel,
      [sideEffect, addressesNotifier, imagesNotifier],
    );

    if (initial.hasError) {
      return const OrderPlacementScreenContentError();
    }

    if (initial.isLoading || !initial.hasValue) {
      return const OrderPlacementScreenContentLoading();
    }

    final orderType = initial.requireValue.$1;
    return OrderPlacementScreenContentLoaded(
      isWorking: isWorking,
      onNavBackClicked: stepsNotifier.onNavBackClicked,
      steps: steps,
      step: steps[stepIndex],
      builder: (context, step) {
        return switch (step) {
          OrderPlacementStep.imagesMove => HookConsumer(
              builder: (context, ref, child) {
                final description = ref.watch(descriptionProvider);
                final images = ref.watch(imagesProvider);
                final isSubmitEnabled = let(() {
                  if (description.trim().isEmpty) return false;
                  if (images.isEmpty) return false;
                  if (images.any((e) => e.$2 == null)) return false;
                  return true;
                });

                return OrderPlacementStepImagesContent(
                  description: description,
                  images: images,
                  orderType: orderType,
                  isSubmitEnabled: isSubmitEnabled,
                  onDescriptionChanged: descriptionNotifier.onValueChanged,
                  onContinueClicked: stepsNotifier.onContinueClicked,
                  onAddImageClicked: imagesNotifier.onAddImageClicked,
                  onRemoveImageClicked: imagesNotifier.onRemoveImageClicked,
                );
              },
            ),
          OrderPlacementStep.imagesGiveAway => HookConsumer(
              builder: (context, ref, child) {
                final description = ref.watch(descriptionProvider);
                final images = ref.watch(imagesProvider);
                final productCondition = ref.watch(productConditionProvider);
                final orderSize = ref.watch(orderSizeProvider);
                final isSubmitEnabled = let(() {
                  if (description.trim().isEmpty) return false;
                  if (images.isEmpty) return false;
                  if (images.any((e) => e.$2 == null)) return false;
                  return true;
                });

                return OrderPlacementStepImagesGiveAwayContent(
                  orderSize: orderSize,
                  productCondition: productCondition,
                  description: description,
                  images: images,
                  isSubmitEnabled: isSubmitEnabled,
                  onDescriptionChanged: descriptionNotifier.onValueChanged,
                  onContinueClicked: stepsNotifier.onContinueClicked,
                  onAddImageClicked: imagesNotifier.onAddImageClicked,
                  onRemoveImageClicked: imagesNotifier.onRemoveImageClicked,
                  onProductConditionClicked:
                      productConditionNotifier.onValueChanged,
                  onOrderSizeTypeClicked: orderSizeNotifier.onValueChanged,
                );
              },
            ),
          OrderPlacementStep.inventory => HookConsumer(
              builder: (context, ref, child) {
                final description = ref.watch(descriptionProvider);
                final images = ref.watch(imagesProvider);
                final isSubmitEnabled = let(() {
                  if (description.trim().isEmpty) return false;
                  if (images.isEmpty) return false;
                  if (images.any((e) => e.$2 == null)) return false;
                  return true;
                });

                return OrderPlacementStepImagesContent(
                  description: description,
                  images: images,
                  orderType: orderType,
                  isSubmitEnabled: isSubmitEnabled,
                  onDescriptionChanged: descriptionNotifier.onValueChanged,
                  onContinueClicked: stepsNotifier.onContinueClicked,
                  onAddImageClicked: imagesNotifier.onAddImageClicked,
                  onRemoveImageClicked: imagesNotifier.onRemoveImageClicked,
                );
              },
            ),
          OrderPlacementStep.address => HookConsumer(
              builder: (context, ref, child) {
                final pickUpTimes = ref.watch(pickUpTimesProvider);
                final addresses = ref.watch(addressesProvider);
                final isSubmitEnabled = let(() {
                  if (pickUpTimes.isEmpty) return false;
                  final pickUpAddress = addresses.getAtOrNull(pickUpAddressKey);
                  if (pickUpAddress == null || !pickUpAddress.isFilled)
                    return false;
                  if (orderType != OrderType.giveAway) {
                    final deliveryAddress =
                        addresses.getAtOrNull(pickUpAddressKey + 1);
                    if (deliveryAddress == null || !deliveryAddress.isFilled)
                      return false;
                  }
                  return true;
                });

                return OrderPlacementStepAddressContent(
                  addresses: addresses,
                  isSubmitEnabled: isSubmitEnabled,
                  onHasElevatorToggled: addressesNotifier.onHasElevatorToggled,
                  onFloorContentChanged:
                      addressesNotifier.onFloorContentChanged,
                  onDoorCodeContentChanged:
                      addressesNotifier.onDoorCodeContentChanged,
                  onContactPhoneContentChanged:
                      addressesNotifier.onContactPhoneContentChanged,
                  onStreetAddressClicked:
                      addressesNotifier.onStreetAddressClicked,
                  onAddDeliveryAddressClicked:
                      addressesNotifier.onAddDeliveryAddressClicked,
                  onPickUpTimesChanged: pickUpTimesNotifier.onValueChanged,
                  onContinueClicked: stepsNotifier.onContinueClicked,
                );
              },
            ),
          OrderPlacementStep.price => HookConsumer(
              builder: (context, ref, child) {
                final finalPrice = ref.watch(finalPriceProvider);
                final orderSize = ref.watch(orderSizeProvider);
                final numOfWorkersRequested =
                    ref.watch(numOfWorkersRequestedProvider);
                final recommendation = ref.watch(recommendationProvider)!;
                return OrderPlacementStepPriceContent(
                  finalPrice: finalPrice,
                  orderSize: orderSize,
                  numOfWorkersRequested: numOfWorkersRequested,
                  recommendation: recommendation,
                  onContinueClicked: stepsNotifier.onContinueClicked,
                  onOrderSizeChanged: orderSizeNotifier.onValueChanged,
                  onNumOfWorkerRequestedChanged:
                      numOfWorkersRequestedNotifier.onValueChanged,
                  onFinalPriceChanged: finalPriceNotifier.onValueChanged,
                );
              },
            ),
          OrderPlacementStep.review => HookConsumer(
              builder: (context, ref, child) {
                final description = ref.watch(descriptionProvider);
                final images = ref.watch(imagesProvider);
                final finalPrice = ref.watch(finalPriceProvider);
                final orderSize = ref.watch(orderSizeProvider);
                final numOfWorkersRequested =
                    ref.watch(numOfWorkersRequestedProvider);
                final pickUpTimes = ref.watch(pickUpTimesProvider);
                final addresses = ref.watch(addressesProvider);
                final productCondition = ref.watch(productConditionProvider);
                final isTermAccepted = ref.watch(isTermAcceptedProvider);
                final recommendation = ref.watch(recommendationProvider);
                final adminFee = recommendation?.adminFee ?? 0.0;
                final currency = recommendation?.currency ?? Currency.SEK;

                return OrderPlacementStepReviewContent(
                  description: description,
                  images: images,
                  orderType: orderType,
                  addresses: addresses,
                  pickUpTimes: pickUpTimes,
                  orderSize: orderSize,
                  numOfWorkersRequested: numOfWorkersRequested,
                  productCondition: productCondition
                      .takeIf((it) => orderType != OrderType.giveAway),
                  finalPrice: finalPrice,
                  adminFee: adminFee,
                  currency: currency,
                  isTermAccepted: isTermAccepted,
                  onContinueClicked: stepsNotifier.onContinueClicked,
                  onAcceptTermChanged: isTermAcceptedNotifier.onValueChanged,
                );
              },
            ),
        };
      },
    );
  }
}

class OrderPlacementScreenScaffold extends StatelessWidget {
  final Widget child;
  final int index;
  final List<String> items;

  const OrderPlacementScreenScaffold({
    super.key,
    required this.child,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: OrderPlacementContentHeader(
          index: index,
          items: items,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: child,
      ),
    );
  }
}
