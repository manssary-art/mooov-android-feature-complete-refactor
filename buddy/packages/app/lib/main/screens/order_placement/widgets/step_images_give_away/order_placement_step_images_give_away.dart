import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/types/order_size_type.dart';
import '../../../../../models/types/product_condition_type.dart';
import '../../widgets/order_placement_content_description_input.dart';
import '../../widgets/order_placement_content_gallery.dart';
import '../../widgets/order_placement_content_order_size_switch.dart';
import '../../widgets/order_placement_content_product_condition_switch.dart';

class OrderPlacementStepImagesGiveAwayContent extends HookWidget {
  final OrderSize orderSize;
  final ProductCondition productCondition;
  final String description;
  final List<(XFile? local, String? remote)> images;
  final bool isSubmitEnabled;
  final void Function(String value) onDescriptionChanged;
  final void Function(int index) onRemoveImageClicked;
  final void Function(ProductCondition value) onProductConditionClicked;
  final void Function(OrderSize value) onOrderSizeTypeClicked;
  final void Function() onAddImageClicked;
  final void Function() onContinueClicked;

  const OrderPlacementStepImagesGiveAwayContent({
    super.key,
    required this.orderSize,
    required this.productCondition,
    required this.description,
    required this.images,
    required this.isSubmitEnabled,
    required this.onDescriptionChanged,
    required this.onContinueClicked,
    required this.onAddImageClicked,
    required this.onRemoveImageClicked,
    required this.onProductConditionClicked,
    required this.onOrderSizeTypeClicked,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.GiveAwayUSP.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              OrderPlacementContentGallery(
                items: images,
                onRemoveClicked: (index) => onRemoveImageClicked(index),
                onItemClicked: (index) => images.getAtOrNull(index) == null ? onAddImageClicked() : null,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.HowCondition.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              OrderPlacementContentProductConditionSwitch(
                selected: productCondition,
                onItemClicked: onProductConditionClicked,
              ),
              const SizedBox(height: 16),
              OrderPlacementContentDescriptionInput(
                title: LocaleKeys.GiveAway.tr(),
                content: description,
                onContentChanged: onDescriptionChanged,
              ),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.PriceViewTitle.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              OrderPlacementContentOrderSizeSwitch(
                selected: orderSize,
                onItemClicked: onOrderSizeTypeClicked,
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
                onPressed: onContinueClicked.takeIf((_) => isSubmitEnabled),
                child: Text(LocaleKeys.Continue.tr()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
