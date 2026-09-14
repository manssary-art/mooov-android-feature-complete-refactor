import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/order_model.dart';
import '../../../../models/types/order_state_type.dart';
import '../../../../models/types/order_type.dart';

final _dateFormatter = DateFormat().add_yMMMd();
final _timeFormatter = DateFormat().add_Hm();

class ExploreOrderListItem extends StatelessWidget {
  final OrderModel order;

  const ExploreOrderListItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final image = order.images?.firstOrNull();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      height: 150,
      child: Row(
        children: [
          _ExploreOrderListItemImage(
            image: image,
            state: order.orderState,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (context) {
                          final firstPickupTime = order.pickupTime?.firstOrNull();
                          DateTime? finalPickupTime;
                          if (order.orderState != OrderState.created && order.finalPickupTime != null) {
                            finalPickupTime = order.finalPickupTime!;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (firstPickupTime != null) ...[
                                SimpleAssetImageTextTile(
                                  image: Assets.images.iconCalendarGreen,
                                  text: _dateFormatter.format(firstPickupTime),
                                ),
                              ],
                              if (finalPickupTime != null) ...[
                                SimpleAssetImageTextTile(
                                  image: Assets.images.iconClockRed,
                                  text: _timeFormatter.format(finalPickupTime),
                                ),
                              ],
                              if (order.pickupAddress?.city != null) ...[
                                Text(
                                  order.pickupAddress!.city!,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                              Container(height: 8),
                              if (order.description != null) ...[
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    order.description!,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ]
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _ExploreOrderListItemTag(
                          category: order.orderType,
                          currency: order.currency,
                          finalPrice: order.finalPrice,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreOrderListItemImage extends StatelessWidget {
  final String? image;
  final OrderState state;

  const _ExploreOrderListItemImage({
    super.key,
    required this.image,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          if (image != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(144 / 8)),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, _, __) => Container(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: const Center(child: LoadingIndicator()),
                ),
                errorWidget: (context, _, __) => Assets.images.iconAppLauncher.image(),
                fit: BoxFit.cover,
                imageUrl: image!,
                height: 144,
                width: 144,
              ),
            ),
          ],
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              constraints: const BoxConstraints(minWidth: 72),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: state == OrderState.created
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Text(
                state.description,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreOrderListItemTag extends StatelessWidget {
  final OrderType category;
  final Currency currency;
  final Money finalPrice;

  const _ExploreOrderListItemTag({
    super.key,
    required this.category,
    required this.currency,
    required this.finalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 96),
      decoration: BoxDecoration(
        color: let(() {
          switch (category) {
            case OrderType.move:
            case OrderType.buyForMe:
            case OrderType.fetchForMe:
              return Theme.of(context).primaryColor;
            case OrderType.giveAway:
              return ColorName.orderGiveAwait;
            case OrderType.recycle:
              return ColorName.orderRecycle;
          }
        }),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
        ),
      ),
      child: Text(
        let(() {
          switch (category) {
            case OrderType.move:
            case OrderType.buyForMe:
            case OrderType.fetchForMe:
            case OrderType.recycle:
              return currency.format(finalPrice);
            case OrderType.giveAway:
              return LocaleKeys.GiveAway.tr();
          }
        }),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: let(() {
            switch (category) {
              case OrderType.move:
              case OrderType.buyForMe:
              case OrderType.fetchForMe:
                return Theme.of(context).textTheme.bodyLarge?.color;
              case OrderType.giveAway:
              case OrderType.recycle:
                return Theme.of(context).scaffoldBackgroundColor;
            }
          }),
        ),
      ),
    );
  }
}

extension on OrderState {
  String get description {
    switch (this) {
      case OrderState.created:
        return LocaleKeys.New.tr();
      case OrderState.assigned:
        return LocaleKeys.Assigned.tr();
      case OrderState.delivered:
        return LocaleKeys.DeliveredStatus.tr();
      case OrderState.completed:
      case OrderState.expired:
      case OrderState.refunded:
        return LocaleKeys.Completed.tr();
    }
  }
}
