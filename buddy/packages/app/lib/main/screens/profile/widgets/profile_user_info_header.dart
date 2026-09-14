import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bootstrap/bootstrap.dart';
import '../../../../models/types/user_level_type.dart';
import '../../../../models/types/user_role_type.dart';
import '../../../../models/user_model.dart';

part 'profile_user_medals.dart';

class ProfileUserInfoHeader extends StatelessWidget {
  final UserModel user;
  final void Function() onOpenUserInfoClicked;
  final void Function() onUpdateVehicleImageClicked;

  const ProfileUserInfoHeader({
    super.key,
    required this.user,
    required this.onOpenUserInfoClicked,
    required this.onUpdateVehicleImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ClipRRect(
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
            if (user.role == UserRole.worker) ...[
              const SizedBox(height: 8),
              Clickable(
                onTap: onUpdateVehicleImageClicked,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(60 / 8)),
                  child: CachedNetworkImage(
                    imageUrl: user.workerInfo?.vehiclesImagesUrls?.firstOrNull ?? '',
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
            if (user.businessInfo != null) ...[
              const SizedBox(height: 8),
              Assets.images.iconBusinessCardBlack.image(
                width: 60,
              ),
            ],
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onOpenUserInfoClicked,
                      child: Text(
                        '${user.firstName} ${user.lastName}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (user.role == UserRole.worker) ...[
                    Clickable(
                      onTap: () async {
                        try {
                          await launchUrl(Uri.parse(Env.workerInfoUrl));
                        } catch (ignore) {
                          // Nothing to do
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFF7620),
                        ),
                        child: Text(
                          LocaleKeys.Info.tr(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Clickable(
                      onTap: onOpenUserInfoClicked,
                      child: Assets.images.iconPencil.image(
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ],
              ),
              Container(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onOpenUserInfoClicked,
                      child: Text(
                        user.email ?? LocaleKeys.EmailOptional.tr(),
                        style: const TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  if (user.role == UserRole.worker) ...[
                    Clickable(
                      onTap: onOpenUserInfoClicked,
                      child: Assets.images.iconPencil.image(
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 16),
              if (user.role == UserRole.user) ...[
                const _ProfileUserMedals(),
              ] else ...[
                _ProfileUserInfoWorkerFooter(user: user),
              ],
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  LocaleKeys.PublishMoreToGet.tr(namedArgs: {'#1': '2'}),
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).disabledColor),
                ),
              )
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
