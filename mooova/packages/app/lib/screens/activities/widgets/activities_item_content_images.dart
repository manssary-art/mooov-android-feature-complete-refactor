import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/order_type.dart';

class ActivitiesItemContentImages extends StatelessWidget {
  final String? pickUpImage;
  final String? deliveredImage;
  final OrderType orderType;
  final VoidCallback? onPickUpImageClicked;
  final VoidCallback? onDeliveredImageClicked;

  const ActivitiesItemContentImages({
    super.key,
    required this.orderType,
    this.pickUpImage,
    this.deliveredImage,
    this.onPickUpImageClicked,
    this.onDeliveredImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Clickable(
          onTap: onPickUpImageClicked,
          child: _ActivitiesItemContentImage(
            imageUrl: pickUpImage,
            description: LocaleKeys.PickedUp.tr(),
            placeholder: Builder(
              builder: (context) {
                if (onPickUpImageClicked == null) {
                  return Container(
                    color: ColorName.neutral10,
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.ComingSoon.tr(),
                    ),
                  );
                }

                return Assets.images.imageCamera.image();
              },
            ),
          ),
        ),
        Expanded(
          child: Builder(builder: (context) {
            if (orderType == OrderType.giveAway) {
              return const SizedBox();
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++) ...[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Bullet(color: Theme.of(context).dividerColor),
                    ),
                  ),
                ],
              ],
            );
          }),
        ),
        Clickable(
          onTap: onDeliveredImageClicked,
          child: _ActivitiesItemContentImage(
            imageUrl: deliveredImage,
            description: deliveredImage == null && onDeliveredImageClicked == null ? null : LocaleKeys.Delivered.tr(),
            placeholder: Builder(
              builder: (context) {
                if (onDeliveredImageClicked == null) {
                  return Container(
                    color: ColorName.neutral10,
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.ComingSoon.tr(),
                    ),
                  );
                }

                return Assets.images.imageCamera.image();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivitiesItemContentImage extends StatelessWidget {
  final String? imageUrl;
  final String? description;
  final Widget placeholder;

  const _ActivitiesItemContentImage({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    const imageSize = 120.0;
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(imageSize / 8)),
          child: Builder(
            builder: (context) {
              if (imageUrl != null) {
                return CachedNetworkImage(
                  progressIndicatorBuilder: (context, _, __) => Container(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: const Center(child: LoadingIndicator()),
                  ),
                  errorWidget: (context, _, __) => Assets.images.iconAppLauncher.image(),
                  fit: BoxFit.cover,
                  imageUrl: imageUrl!,
                  height: imageSize,
                  width: imageSize,
                );
              }

              return SizedBox(
                height: imageSize,
                width: imageSize,
                child: placeholder,
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(description ?? ''),
      ],
    );
  }
}
