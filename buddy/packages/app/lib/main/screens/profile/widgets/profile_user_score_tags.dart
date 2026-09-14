import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/tile/rating_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';

class ProfileUserScoreTags extends StatelessWidget {
  final UserModel user;

  const ProfileUserScoreTags({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final rating = user.workerInfo?.rating ?? 4.0;
    final tags = user.workerInfo?.tags?.mapNotNull((e) {
      try {
        return e.toLowerCase().tr();
      } catch (_) {
        return e;
      }
    }).toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 4),
            RatingTile(size: 32, value: rating),
          ],
        ),
        if (tags != null && tags.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: TagTextWrapCompact(
              items: tags,
              alignment: WrapAlignment.center,
            ),
          ),
        ]
      ],
    );
  }
}
