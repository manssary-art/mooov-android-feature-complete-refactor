import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../models/worker_application_form_status.dart';
import '../worker_application_form_image_field.dart';
import '../worker_application_form_input_container.dart';
import '../worker_application_form_input_field.dart';
import '../worker_application_form_status.dart';

part 'worker_application_form_screen_content_error.dart';

part 'worker_application_form_screen_content_loaded.dart';

part 'worker_application_form_screen_content_loading.dart';

class _WorkerApplicationFormScreenScaffold extends HookWidget {
  final VoidCallback onNavBackClicked;
  final Widget body;

  const _WorkerApplicationFormScreenScaffold({
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
