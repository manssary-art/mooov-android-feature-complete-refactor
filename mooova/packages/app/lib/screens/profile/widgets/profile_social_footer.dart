import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bootstrap/bootstrap.dart';

class ProfileSocialFooter extends HookWidget {
  final void Function() onSignOutClicked;

  const ProfileSocialFooter({
    super.key,
    required this.onSignOutClicked,
  });

  @override
  Widget build(BuildContext context) {
    final platformInfo = useFuture(PackageInfo.fromPlatform());
    final style = Theme.of(context).textTheme.bodySmall;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSocialMediaIcon(
              url: Env.socialFacebookUrl,
              icon: Assets.images.iconSocialFacebook,
            ),
            Container(width: 16),
            buildSocialMediaIcon(
              url: Env.socialInstagramUrl,
              icon: Assets.images.iconSocialInstagram,
            ),
            Container(width: 16),
            buildSocialMediaIcon(
              url: Env.socialLinkedinUrl,
              icon: Assets.images.iconSocialLinkedin,
            )
          ],
        ),
        Container(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onSignOutClicked,
              child: Text(
                LocaleKeys.Logout.tr(),
                style: style,
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Version: ${platformInfo.data?.version}', style: style),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  await launchUrl(Uri.parse(Env.privacyPolicyUrl));
                } catch (ignore) {
                  // Nothing to do
                }
              },
              child: Text(
                LocaleKeys.PrivacyPolicy.tr(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSocialMediaIcon({
    required String url,
    required AssetGenImage icon,
  }) {
    return Clickable(
      onTap: () async {
        try {
          await launchUrl(Uri.parse(url));
        } catch (ignore) {
          // Nothing to do
        }
      },
      child: Opacity(
        opacity: 0.5,
        child: icon.image(
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
