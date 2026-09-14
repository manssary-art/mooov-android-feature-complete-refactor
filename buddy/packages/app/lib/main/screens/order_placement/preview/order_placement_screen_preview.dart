import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../models/order_address_model.dart';
import '../../../../models/order_price_recommendation_model.dart';
import '../../../../models/types/order_size_type.dart';
import '../../../../models/types/order_type.dart';
import 'package:preview/preview.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/riverpod_ext.dart';
import '../models/order_placement_steps.dart';
import '../widgets/content/order_placement_screen_content.dart';
import '../widgets/step_address/order_placement_step_address.dart';
import '../widgets/step_images/order_placement_step_images.dart';
import '../widgets/step_images_give_away/order_placement_step_images_give_away.dart';
import '../widgets/step_price/order_placement_step_price.dart';
import '../widgets/step_review/order_placement_step_review.dart';

class OrderPlacementScreenPreview extends HookWidget with PreviewMixin {
  OrderPlacementScreenPreview({
    super.key,
  });

  @override
  String get name => 'OrderPlacementScreen';

  @override
  Widget build(BuildContext context) {
    final orderTypes = OrderType.values.associateBy((e) => e.name);
    final orderType = usePreviewOptions('OrderType', orderTypes.keys.toList()).let((it) => orderTypes[it]!);
    final steps = orderType.asSteps.associateBy((e) => e.name);
    final step = usePreviewOptions('Step', steps.keys.toList()).let((it) => steps[it]!);
    final order = useMemoized(() => fakeOrderModel().copyWith(orderType: () => orderType), [orderType]);
    return OrderPlacementScreenContentLoaded(
      key: ValueKey(order),
      isWorking: false,
      onNavBackClicked: () {},
      steps: orderType.asSteps,
      step: step,
      builder: (context, step) {
        return switch (step) {
          OrderPlacementStep.imagesMove => HookBuilder(
              builder: (context) {
                final description = useState(order.description ?? '');
                final images = useState(order.images ?? []);
                return OrderPlacementStepImagesContent(
                  description: description.value,
                  images: images.value.map((e) => (null, e)).toList(),
                  orderType: orderType,
                  isSubmitEnabled: true,
                  onDescriptionChanged: description.onValueChanged,
                  onContinueClicked: () {},
                  onAddImageClicked: () => images.value = images.value.plus(fakeImageUrl),
                  onRemoveImageClicked: (value) => images.value = images.value.minusAt(value),
                );
              },
            ),
          OrderPlacementStep.imagesGiveAway => HookBuilder(
              builder: (context) {
                final description = useState(order.description ?? '');
                final images = useState(order.images ?? []);
                final orderSize = useState(order.orderSize);
                final productCondition = useState(order.productCondition);
                return OrderPlacementStepImagesGiveAwayContent(
                  orderSize: orderSize.value,
                  productCondition: productCondition.value,
                  description: description.value,
                  images: images.value.map((e) => (null, e)).toList(),
                  isSubmitEnabled: true,
                  onDescriptionChanged: description.onValueChanged,
                  onContinueClicked: () {},
                  onAddImageClicked: () => images.value = images.value.plus(fakeImageUrl),
                  onRemoveImageClicked: (value) => images.value = images.value.minusAt(value),
                  onProductConditionClicked: productCondition.onValueChanged,
                  onOrderSizeTypeClicked: orderSize.onValueChanged,
                );
              },
            ),
          OrderPlacementStep.inventory => HookBuilder(
              builder: (context) {
                final description = useState(order.description ?? '');
                final images = useState(order.images ?? []);
                return OrderPlacementStepImagesContent(
                  description: description.value,
                  images: images.value.map((e) => (null, e)).toList() ?? [],
                  orderType: orderType,
                  isSubmitEnabled: true,
                  onDescriptionChanged: description.onValueChanged,
                  onContinueClicked: () {},
                  onAddImageClicked: () => images.value = images.value.plus(fakeImageUrl),
                  onRemoveImageClicked: (value) => images.value = images.value.minusAt(value),
                );
              },
            ),
          OrderPlacementStep.address => HookBuilder(
              builder: (context) {
                final pickUptimes = useState(order.pickupTime ?? []);
                final addresses = useState([order.pickupAddress!, ...order.deliveryAddresses!]);
                return OrderPlacementStepAddressContent(
                  addresses: addresses.value,
                  isSubmitEnabled: true,
                  onHasElevatorToggled: (key, value) => addresses.value = addresses.value
                      .mapIndexed((i, e) => i == key ? e.copyWith(hasElevator: () => value) : e)
                      .toList()
                      // ignore: invalid_use_of_protected_member
                      .also((it) => addresses.notifyListeners()),
                  onFloorContentChanged: (key, value) => addresses.value =
                      addresses.value.mapIndexed((i, e) => i == key ? e.copyWith(floor: () => value) : e).toList(),
                  onDoorCodeContentChanged: (key, value) => addresses.value = addresses.value
                      .mapIndexed((i, e) => i == key ? e.copyWith(doorEntryCode: () => value) : e)
                      .toList()
                      // ignore: invalid_use_of_protected_member
                      .also((it) => addresses.notifyListeners()),
                  onContactPhoneContentChanged: (key, value) => addresses.value = addresses.value
                      .mapIndexed((i, e) => i == key ? e.copyWith(contactPhone: () => value) : e)
                      .toList()
                      // ignore: invalid_use_of_protected_member
                      .also((it) => addresses.notifyListeners()),
                  onStreetAddressClicked: (value) {},
                  onAddDeliveryAddressClicked: () => addresses.value =
                      // ignore: invalid_use_of_protected_member
                      addresses.value.plus(OrderAddressModel.empty()).also((it) => addresses.notifyListeners()),
                  onPickUpTimesChanged: pickUptimes.onValueChanged,
                  onContinueClicked: () {},
                );
              },
            ),
          OrderPlacementStep.price => HookBuilder(
              builder: (context) {
                final orderSize = useState(order.orderSize);
                final finalPrice = useState<num>(order.finalPrice);
                final numOfWorkersRequested = useState(order.numOfWorkersRequested ?? 1);
                return OrderPlacementStepPriceContent(
                  finalPrice: finalPrice.value,
                  orderSize: orderSize.value,
                  numOfWorkersRequested: numOfWorkersRequested.value,
                  recommendation: useMemoized(
                    () => const OrderPriceRecommendationModel(
                      currency: Currency.SEK,
                      adminFee: 0.0,
                      priceLimit: 10000,
                      estimatedPrice: 10000,
                      additionalWorkerPrice: 200,
                      time: 10,
                      taxiPrice: 1000,
                      rentalPrice: 1000,
                      orderSize: OrderSize.m,
                    ),
                  ),
                  onContinueClicked: () {},
                  onOrderSizeChanged: orderSize.onValueChanged,
                  onNumOfWorkerRequestedChanged: numOfWorkersRequested.onValueChanged,
                  onFinalPriceChanged: finalPrice.onValueChanged,
                );
              },
            ),
          OrderPlacementStep.review => HookBuilder(
              builder: (context) {
                final isTermAccepted = useState(false);
                return OrderPlacementStepReviewContent(
                  description: order.description ?? '',
                  images: order.images?.map((e) => (null, e)).toList() ?? [],
                  orderType: orderType,
                  addresses: [order.pickupAddress!, ...order.deliveryAddresses!],
                  pickUpTimes: order.pickupTime ?? [],
                  orderSize: order.orderSize,
                  numOfWorkersRequested: order.numOfWorkersRequested ?? 1,
                  productCondition: order.productCondition.takeIf((it) => orderType != OrderType.giveAway),
                  finalPrice: order.finalPrice,
                  adminFee: order.adminFee ?? 0.0,
                  currency: order.currency,
                  isTermAccepted: isTermAccepted.value,
                  onContinueClicked: () {},
                  onAcceptTermChanged: isTermAccepted.onValueChanged,
                );
              },
            ),
        };
      },
    );
  }
}
