import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:preview/preview.dart';

import '../main/app/setup/setup_easy_localization.dart';
import '../main/app/setup/setup_material_app_child.dart';

class PreviewSetupApp extends StatelessWidget {
  final List<PreviewMixin> screens;

  const PreviewSetupApp({
    super.key,
    required this.screens,
  });

  @override
  Widget build(BuildContext context) {
    return SetupEasyLocalization(
      builder: (context)  {
        return PreviewApp(
          screens: screens,
          availableLocales: context.supportedLocales,
          builder: (context, child, config) {
            final currentLocale = context.locale;
            context.setLocale(config.locale);

            return MaterialApp(
              key: ValueKey('MaterialApp.$currentLocale'),
              useInheritedMediaQuery: true,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              builder: (context, child) => SetupMaterialAppChild(builder: (context) => child!),
              theme: theme,
              home: child,
            );
          },
        );
      }
    );
  }
}
