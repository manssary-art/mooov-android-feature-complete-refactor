import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../health/riverpod_observer.dart';
import 'setup/setup_easy_localization.dart';
import 'setup/setup_global_loader_overlay.dart';
import 'setup/setup_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [RiverpodObserver()],
      child: SetupEasyLocalization(
        builder: (context) => SetupGlobalLoaderOverlay(
          builder: (context) => const SetupMaterialApp(),
        ),
      ),
    );
  }
}
