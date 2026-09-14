import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../core/hooks/flutter_hooks.dart';
import '../../../../../core/hooks/use_copy_to_clipboard.dart';
import '../../../../../core/hooks/use_open_on_external_map.dart';
import '../../ext/activities_order_item_ext.dart';
import '../../models/activities_order_item.dart';
import '../../models/activities_tab.dart';
import '../activities_content_empty.dart';
import '../activities_item_content.dart';

part 'activities_screen_content_error.dart';

part 'activities_screen_content_loaded.dart';

part 'activities_screen_content_loading.dart';

class _ActivitiesScreenScaffold extends HookWidget {
  final ActivitiesTab selectedTab;
  final void Function(ActivitiesTab) onTabClicked;
  final Widget body;

  const _ActivitiesScreenScaffold({
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
            onItemClicked: (index) => onTabClicked(ActivitiesTab.values[index]),
            selectedIndex: ActivitiesTab.values.indexOf(selectedTab),
            items: ActivitiesTab.values.map((e) {
              switch (e) {
                case ActivitiesTab.active:
                  return LocaleKeys.Active.tr();
                case ActivitiesTab.completed:
                  return LocaleKeys.Completed.tr();
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
