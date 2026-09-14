import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/types/user_role_type.dart';
import '../../../../../models/user_model.dart';
import '../profile_ice_banner.dart';
import '../profile_option_buttons.dart';
import '../profile_referral_share_card.dart';
import '../profile_social_footer.dart';
import '../profile_user_info_header.dart';
import '../profile_user_score_tags.dart';
import '../profile_user_statistics.dart';

part 'profile_screen_content_loaded.dart';

part 'profile_screen_content_loading.dart';

part 'profile_screen_content_error.dart';

class _ProfileScreenScaffold extends HookWidget {
  final UserRole selectedTab;
  final void Function(UserRole) onTabClicked;
  final Widget body;

  const _ProfileScreenScaffold({
    super.key,
    required this.selectedTab,
    required this.onTabClicked,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: kToolbarHeight * 2,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AnimatedTabSelector(
            onItemClicked: (index) => onTabClicked(UserRole.values[index]),
            selectedIndex: UserRole.values.indexOf(selectedTab),
            items: UserRole.values.map((e) {
              switch (e) {
                case UserRole.user:
                  return LocaleKeys.Owner.tr();
                case UserRole.worker:
                  return LocaleKeys.Mooover.tr();
              }
            }).toList(),
          ),
        ),
      ),
      body: ScaffoldRoundedBody(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: body,
      ),
    );
  }
}
