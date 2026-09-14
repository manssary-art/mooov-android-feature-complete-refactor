import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/types/order_type.dart';
import '../../widgets/order_placement_content_description_input.dart';
import '../../widgets/order_placement_content_gallery.dart';

class OrderPlacementStepImagesContent extends HookWidget {
  final String description;
  final List<(XFile? local, String? remote)> images;
  final OrderType orderType;
  final bool isSubmitEnabled;
  final void Function(String value) onDescriptionChanged;
  final void Function(int index) onRemoveImageClicked;
  final void Function() onAddImageClicked;
  final void Function() onContinueClicked;

  const OrderPlacementStepImagesContent({
    super.key,
    required this.description,
    required this.images,
    required this.orderType,
    required this.isSubmitEnabled,
    required this.onDescriptionChanged,
    required this.onContinueClicked,
    required this.onAddImageClicked,
    required this.onRemoveImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Text(
                orderType.let((category) {
                  switch (category) {
                    case OrderType.move:
                    case OrderType.buyForMe:
                    case OrderType.fetchForMe:
                      return LocaleKeys.TransportUSP.tr();
                    case OrderType.giveAway:
                      return LocaleKeys.GiveAwayUSP.tr();
                    case OrderType.recycle:
                      return LocaleKeys.RecycleUSP.tr();
                  }
                }),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              OrderPlacementContentGallery(
                items: images,
                onRemoveClicked: (index) => onRemoveImageClicked(index),
                onItemClicked: (index) => images.getAtOrNull(index) == null ? onAddImageClicked() : null,
              ),
              const SizedBox(height: 16),
              OrderPlacementContentDescriptionInput(
                title: orderType.let((category) {
                  switch (category) {
                    case OrderType.move:
                    case OrderType.buyForMe:
                    case OrderType.fetchForMe:
                      return LocaleKeys.MoveHeader2.tr();
                    case OrderType.giveAway:
                      return LocaleKeys.GiveAwayHeader2.tr();
                    case OrderType.recycle:
                      return LocaleKeys.RecycleHeader2.tr();
                  }
                }),
                content: description,
                onContentChanged: onDescriptionChanged,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FilledButton(
              onPressed: onContinueClicked.takeIf((_) => isSubmitEnabled),
              child: Text(LocaleKeys.Continue.tr()),
            ),
          ),
        ),
      ],
    );
  }
}
