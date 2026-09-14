import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bootstrap/bootstrap.dart';
import '../../../../models/types/user_role_type.dart';
import '../../../../models/user_model.dart';

class ProfileOptionButtons extends HookWidget {
  final UserModel user;
  final void Function() onOpenSavedCardClicked;
  final void Function() onOpenNotificationSettingsClicked;
  final void Function() onOpenWorkerApplicationFormClicked;
  final void Function() onOpenBusinessInfoClicked;

  const ProfileOptionButtons({
    super.key,
    required this.user,
    required this.onOpenSavedCardClicked,
    required this.onOpenNotificationSettingsClicked,
    required this.onOpenWorkerApplicationFormClicked,
    required this.onOpenBusinessInfoClicked,
  });

  @override
  Widget build(BuildContext context) {
    final onSupportClicked = useCallback(() async {
      try {
        await launchUrl(Uri(
          scheme: 'mailto',
          path: Env.supportEmail,
          queryParameters: {
            'subject': 'General support',
            'body': 'UID:${user.userId}\n\n',
          },
        ));
      } catch (ignore) {
        // Nothing to do
      }
    }, [user.userId]);

    final options = [
      if (user.role == UserRole.user) ...[
        _ProfileOptionData(
          LocaleKeys.PaymentMethod,
          Assets.images.iconCard,
          onOpenSavedCardClicked,
        ),
        _ProfileOptionData(
          LocaleKeys.Notifications,
          Assets.images.iconBell,
          onOpenNotificationSettingsClicked,
        ),
        _ProfileOptionData(
          LocaleKeys.Support,
          Assets.images.iconSupport,
          onSupportClicked,
        ),
        _ProfileOptionData(
          LocaleKeys.BecomeMooover,
          Assets.images.iconVan,
          onOpenWorkerApplicationFormClicked,
          const Color(0xFF07A5F6),
        ),
        _ProfileOptionData(
          LocaleKeys.UpgradeToBusiness,
          Assets.images.iconStore,
          onOpenBusinessInfoClicked,
          const Color(0xFF6382FF),
        ),
      ] else ...[
        _ProfileOptionData(
          LocaleKeys.ReviewApplication,
          Assets.images.iconVan,
          onOpenWorkerApplicationFormClicked,
        ),
        _ProfileOptionData(
          LocaleKeys.Notifications,
          Assets.images.iconBell,
          onOpenNotificationSettingsClicked,
        ),
        _ProfileOptionData(
          LocaleKeys.Support,
          Assets.images.iconSupport,
          onSupportClicked,
        ),
        _ProfileOptionData(
          LocaleKeys.UpgradeToBusiness,
          Assets.images.iconStore,
          onOpenBusinessInfoClicked,
          const Color(0xFF06382F),
        ),
      ]
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final item in options) ...[
          SizedBox(
            width: 120,
            child: Clickable(
              onTap: item.onTap,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (item.image != null) ...[
                      item.image!.image(
                        width: 32,
                        height: 32,
                      ),
                    ],
                    const SizedBox(height: 8),
                    if (item.text != null) ...[
                      Text(
                        item.text!.tr(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 12,
                              color: item.textColor,
                            ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}

class _ProfileOptionData {
  final String? text;
  final AssetGenImage? image;
  final void Function()? onTap;
  final Color? textColor;

  _ProfileOptionData(this.text, this.image, this.onTap, [this.textColor]);
}
