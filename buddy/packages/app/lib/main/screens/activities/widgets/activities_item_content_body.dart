import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/order_address_model.dart';
import '../../../../models/order_model.dart';

final _formatter = DateFormat().add_yMMMd();

class ActivitiesItemBody extends StatelessWidget {
  final OrderModel order;
  final ValueSetter<String>? onCopyAddressClicked;
  final ValueSetter<OrderAddressModel>? onNavigateClicked;

  const ActivitiesItemBody({
    super.key,
    required this.order,
    this.onCopyAddressClicked,
    this.onNavigateClicked,
  });

  @override
  Widget build(BuildContext context) {
    final address = onCopyAddressClicked != null
        ? order.pickupAddress!.displayAddressObfuscated
        : order.pickupAddress!.displayAddress;
    final imageUrl = order.images?.firstOrNull((it) => it.isNotEmpty);
    final pickUpTime = order.pickupTime?.first;
    final finalPrice = order.finalPrice;
    final finalPickupTime = order.finalPickupTime;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(80 / 8)),
          child: CachedNetworkImage(
            progressIndicatorBuilder: (context, _, __) => Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: const Center(child: LoadingIndicator()),
            ),
            errorWidget: (context, _, __) => Assets.images.iconAppLauncher.image(),
            fit: BoxFit.cover,
            imageUrl: imageUrl ?? '',
            height: 80,
            width: 80,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    if (pickUpTime != null) ...[
                      Expanded(
                        child: SimpleAssetImageTextTile(
                          image: Assets.images.iconCalendarGreen,
                          text: _formatter.format(pickUpTime),
                        ),
                      ),
                    ],
                    if (finalPickupTime != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 60,
                        ),
                        child: Text(
                          '${finalPickupTime.hour}-${finalPickupTime.add(const Duration(hours: 1)).hour}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Clickable(
                  onTap: onCopyAddressClicked != null ? () => onCopyAddressClicked!(address) : null,
                  child: SimpleAssetImageTextTile(
                    image: Assets.images.iconMarkerPickUp,
                    text: address,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SimpleAssetImageTextTile(
                        image: Assets.images.iconWalletYellow,
                        text: LocaleKeys.TotalFee.tr(namedArgs: {'#1': order.currency.format(finalPrice), '#2': ''}),
                      ),
                    ),
                    if (onNavigateClicked != null) ...[
                      GestureDetector(
                        onTap: () => onNavigateClicked!(order.pickupAddress!),
                        child: Transform.rotate(
                          angle: 45,
                          child: const Icon(Icons.navigation),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.chevron_right,
            color: Theme.of(context).dividerColor,
          ),
        )
      ],
    );
  }
}
