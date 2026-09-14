import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/user_model.dart';
import '../models/order_details_display_mode.dart';

class OrderDetailsOwnerUserProfile extends StatelessWidget {
  final UserModel owner;
  final OrderDetailsDisplayMode displayMode;

  const OrderDetailsOwnerUserProfile({
    super.key,
    required this.owner,
    required this.displayMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.Owner.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(height: 8),
        UserProfileTile(
          name: owner.let((it) {
            if (displayMode is OrderDetailsDisplayMode$Owner) return it.displayName;
            if (displayMode is OrderDetailsDisplayMode$WorkerAssigned) return it.displayName;
            return it.displayNameObfuscated;
          }),
          rating: owner.workerInfo?.rating ?? 4.0,
          imageSize: 60,
          imageUrl: owner.image,
        ),
        Container(height: 16),
      ],
    );
  }
}
