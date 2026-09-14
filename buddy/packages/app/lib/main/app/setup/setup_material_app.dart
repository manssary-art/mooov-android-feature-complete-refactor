import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../router/router.dart';
import 'setup_material_app_child.dart';

class SetupMaterialApp extends HookWidget {
  const SetupMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme,
      builder: (context, child) => SetupMaterialAppChild(
        builder: (context) => child!,
      ),
    );
  }
}
