import 'dart:async';

import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../models/explore_ads_model.dart';
import '../../../../../models/order_model.dart';
import '../../../../../models/types/order_state_type.dart';
import '../../../../hooks/flutter_hooks.dart';
import '../../models/explore_tab.dart';
import '../explore_ad_list_item.dart';
import '../explore_order_list_item.dart';

part 'explore_screen_content_error.dart';

part 'explore_screen_content_loaded.dart';

part 'explore_screen_content_loading.dart';

class _ExploreScreenScaffold extends HookWidget {
  final ExploreTab selectedTab;
  final void Function(ExploreTab) onTabClicked;
  final Widget body;

  const _ExploreScreenScaffold({
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
            onItemClicked: (index) => onTabClicked(ExploreTab.values[index]),
            selectedIndex: ExploreTab.values.indexOf(selectedTab),
            items: ExploreTab.values.map((e) {
              switch (e) {
                case ExploreTab.all:
                  return LocaleKeys.All.tr();
                case ExploreTab.available:
                  return LocaleKeys.Available.tr();
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
