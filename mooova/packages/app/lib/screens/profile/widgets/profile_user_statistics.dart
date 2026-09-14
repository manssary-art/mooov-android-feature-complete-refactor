import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/user_role_type.dart';
import '../../../../models/user_model.dart';

class ProfileUserStatistics extends StatelessWidget {
  final UserModel user;

  const ProfileUserStatistics({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final list = <_ProfileUserStatisticData>[];
    if (user.role == UserRole.user) {
      list.add(_ProfileUserStatisticData(
        Assets.images.iconPasteGreen,
        LocaleKeys.StickerTotal,
        "${user.orderCounter ?? 0}",
      ));
      list.add(_ProfileUserStatisticData(
        Assets.images.iconClockBlue,
        LocaleKeys.DaysUsingMooov,
        "-",
      ));
      list.add(_ProfileUserStatisticData(
        Assets.images.icon24Orange,
        LocaleKeys.HoursSaved,
        "-",
      ));
    } else {
      list.add(_ProfileUserStatisticData(
        Assets.images.iconPasteGreen,
        LocaleKeys.StickersTaken,
        "${user.workerInfo?.orderDeliverCounter ?? 0}",
      ));
      list.add(_ProfileUserStatisticData(
        Assets.images.iconClockBlue,
        LocaleKeys.DaysActiveMooover,
        "-",
      ));
      list.add(_ProfileUserStatisticData(
        Assets.images.icon24Orange,
        LocaleKeys.TakeRate,
        "${100 - ((user.workerInfo?.cutRate ?? 0) * 100).toInt()}",
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list
          .mapIndexed(
            (index, value) => [
              Column(
                children: [
                  value.image.image(
                    width: 24,
                    height: 24,
                  ),
                  Container(
                    height: 36,
                    width: 80,
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      value.text.tr(),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    (value.count).toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
              if (index < list.length - 1) ...[
                Container(
                  height: 60,
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ],
            ],
          )
          .expand((i) => i)
          .toList(),
    );
  }
}

class _ProfileUserStatisticData {
  final AssetGenImage image;
  final String text;
  final String count;

  _ProfileUserStatisticData(this.image, this.text, this.count);
}
