import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/order_address_model.dart';
import '../../../../../models/types/order_size_type.dart';
import '../../../../../models/types/order_type.dart';
import '../../../../../models/types/product_condition_type.dart';
import '../../models/order_placement_address.dart';
import '../../widgets/order_placement_content_description_input.dart';
import '../../widgets/order_placement_content_gallery.dart';

part 'order_placement_step_review_accept_conditions.dart';

part 'order_placement_step_review_address.dart';

part 'order_placement_step_review_order_size_num_of_workers.dart';

part 'order_placement_step_review_pickup_times.dart';

part 'order_placement_step_review_price_offer.dart';

part 'order_placement_step_review_product_condition.dart';

class OrderPlacementStepReviewContent extends HookWidget {
  final String description;
  final List<(XFile? local, String? remote)> images;
  final OrderType orderType;
  final List<OrderAddressModel> addresses;
  final List<DateTime> pickUpTimes;
  final OrderSize orderSize;
  final int numOfWorkersRequested;
  final ProductCondition? productCondition;
  final Money finalPrice;
  final Money adminFee;
  final Currency currency;
  final bool isTermAccepted;
  final void Function() onContinueClicked;
  final void Function(bool value) onAcceptTermChanged;

  const OrderPlacementStepReviewContent({
    super.key,
    required this.description,
    required this.images,
    required this.orderType,
    required this.addresses,
    required this.pickUpTimes,
    required this.orderSize,
    required this.numOfWorkersRequested,
    required this.productCondition,
    required this.finalPrice,
    required this.adminFee,
    required this.currency,
    required this.isTermAccepted,
    required this.onContinueClicked,
    required this.onAcceptTermChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                LocaleKeys.Summary.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              OrderPlacementContentGallery(
                items: images,
              ),
              if (productCondition != null) ...[
                const SizedBox(height: 16),
                _OrderPlacementStepReviewContentProductCondition(
                  productCondition: productCondition!,
                ),
              ],
              const SizedBox(height: 16),
              OrderPlacementContentDescriptionInput(
                title: LocaleKeys.Description.tr(),
                content: description,
              ),
              const SizedBox(height: 16),
              _OrderPlacementStepReviewContentOrderSizeNumOfWorkersRequested(
                orderSize: orderSize,
                numOfWorkerRequested: numOfWorkersRequested,
              ),
              const SizedBox(height: 16),
              for (final entry in addresses.asMap().entries) ...[
                _OrderPlacementStepReviewContentAddress(
                  title: let(() {
                    if (entry.key == pickUpAddressKey) return LocaleKeys.PickupAddress.tr();
                    return LocaleKeys.DeliveryAddress.tr();
                  }),
                  icon: let(() {
                    if (entry.key == pickUpAddressKey) return Assets.images.iconMarkerPickUp;
                    return Assets.images.iconMarkerDropOff;
                  }),
                  address: entry.value,
                ),
                const Divider(height: 40),
              ],
              _OrderPlacementStepReviewContentPickUpTimes(
                times: pickUpTimes,
              ),
              const SizedBox(height: 40),
              _OrderPlacementStepReviewContentOffer(
                finalPrice: finalPrice,
                adminFee: adminFee,
                currency: currency,
              ),
              const SizedBox(height: 40),
              _OrderPlacementStepReviewContentAcceptConditions(
                isAccepted: isTermAccepted,
                onAcceptTermClicked: onAcceptTermChanged,
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FilledButton(
                onPressed: onContinueClicked.takeIf((_) => isTermAccepted),
                child: Text(LocaleKeys.Submit.tr()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
