import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/tile/rating_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/user_level_type.dart';
import '../../../../models/user_model.dart';

class OrderWorkerSelectionCandidateHeaderListItem extends HookWidget {
  final UserModel user;
  final void Function() onUserProfileImageClicked;
  final void Function() onUserVehicleImageClicked;

  const OrderWorkerSelectionCandidateHeaderListItem({
    super.key,
    required this.user,
    required this.onUserProfileImageClicked,
    required this.onUserVehicleImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Clickable(
              onTap: onUserProfileImageClicked,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60 / 8)),
                child: CachedNetworkImage(
                  imageUrl: user.image ?? '',
                  width: 60,
                  height: 60,
                  progressIndicatorBuilder: (_, __, ___) => Assets.images.iconLegoGuy.image(
                    width: 60,
                    height: 60,
                  ),
                  errorWidget: (_, __, ___) => Assets.images.iconLegoGuy.image(
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Clickable(
              onTap: onUserVehicleImageClicked,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60 / 8)),
                child: CachedNetworkImage(
                  imageUrl: user.workerInfo?.vehiclesImagesUrls?.firstOrNull() ?? '',
                  width: 60,
                  height: 60,
                  progressIndicatorBuilder: (_, __, ___) => Assets.images.iconTruck.image(
                    width: 60,
                    height: 60,
                  ),
                  errorWidget: (_, __, ___) => Assets.images.iconTruck.image(
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 120,
          width: Theme.of(context).dividerTheme.thickness,
          color: Theme.of(context).dividerColor,
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName ?? user.lastName}'.let((it) => '${it.substring(0, min(it.length, 3))}***'),
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (user.workerInfo?.rating != null) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${user.workerInfo!.rating!}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(width: 4),
                          RatingTile(value: user.workerInfo!.rating!),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              _ProfileUserInfoWorkerFooter(user: user),
            ],
          ),
        )
      ],
    );
  }
}

class _ProfileUserInfoWorkerFooter extends StatelessWidget {
  final UserModel user;

  const _ProfileUserInfoWorkerFooter({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Assets.images.iconPasteGreen.image(
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text("${user.workerInfo?.orderDeliverCounter ?? 0}"),
            const SizedBox(width: 16),
            if (user.level?.color != null) ...[
              ColorFiltered(
                colorFilter: ColorFilter.mode(user.level!.color, BlendMode.modulate),
                child: Assets.images.iconRankMedal.image(
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 8),
              Text(user.level!.text ?? ''),
            ],
          ],
        ),
        if (user.workerInfo?.tags != null && user.workerInfo!.tags!.isNotEmpty) ...[
          const SizedBox(height: 12),
          TagTextWrapCompact(
            items: user.workerInfo!.tags!,
            alignment: WrapAlignment.start,
          ),
        ],
      ],
    );
  }
}

extension on UserLevel {
  Color get color {
    switch (this) {
      case UserLevel.bronze:
        return const Color(0xFFDF9144);
      case UserLevel.silver:
        return const Color(0xFFC2D4D4);
      case UserLevel.gold:
        return const Color(0xFFFFCB1F);
      case UserLevel.platinum:
        return const Color(0xFF847A96);
      default:
        return const Color(0xFFDF9144);
    }
  }

  String get text {
    switch (this) {
      case UserLevel.bronze:
        return "Brozen";
      case UserLevel.silver:
        return "Silver";
      case UserLevel.gold:
        return "Gold";
      case UserLevel.platinum:
        return "Platinum";
      default:
        return "Brozen";
    }
  }
}
