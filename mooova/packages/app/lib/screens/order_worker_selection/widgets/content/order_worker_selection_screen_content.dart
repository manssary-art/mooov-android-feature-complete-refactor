import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/user_model.dart';
import '../../../../../preview/helpers/preview_fake_models.dart';
import '../../../../core/hooks/flutter_hooks.dart';
import '../order_worker_selection_candidate_list_item.dart';

part 'order_worker_selection_screen_content_error.dart';

part 'order_worker_selection_screen_content_loaded.dart';

part 'order_worker_selection_screen_content_loading.dart';

class _OrderWorkerSelectionScreenScaffold extends HookWidget {
  final VoidCallback onNavBackClicked;
  final Widget body;

  const _OrderWorkerSelectionScreenScaffold({
    super.key,
    required this.onNavBackClicked,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: kToolbarHeight * 2,
        leading: BackButton(
          onPressed: onNavBackClicked,
        ),
        title: Center(
          child: Text(
            LocaleKeys.MoooverApplication.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
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
