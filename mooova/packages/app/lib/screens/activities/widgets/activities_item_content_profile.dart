import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/user_model.dart';

class ActivitiesItemContentProfile extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onPhoneCallClicked;
  final VoidCallback? onPhoneSmsClicked;

  const ActivitiesItemContentProfile({
    Key? key,
    required this.user,
    this.onPhoneCallClicked,
    this.onPhoneSmsClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obfuscate = onPhoneSmsClicked == null && onPhoneCallClicked == null;
    final name = obfuscate ? user.displayNameObfuscated : user.displayName;
    return Column(
      children: [
        UserProfileTile(
          name: name,
          rating: user.workerInfo?.rating,
          tags: user.workerInfo?.tags,
          imageUrl: user.image,
          imageSize: 40,
        ),
        if (user.phone != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              if (onPhoneCallClicked != null) ...[
                Clickable(
                  onTap: () => onPhoneCallClicked!(),
                  child: Assets.images.iconCircledPhone.image(
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
              if (onPhoneCallClicked != null && onPhoneSmsClicked != null) ...[
                const SizedBox(width: 8),
              ],
              if (onPhoneSmsClicked != null) ...[
                Clickable(
                  onTap: () => onPhoneSmsClicked!(),
                  child: Assets.images.iconCircledMessage.image(
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
