import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'bootstrap/bootstrap.dart';
import 'main/app/app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await bootstrap();
      runApp(const App());
    },
    (error, stack) {
      PlatformDispatcher.instance.onError?.call(error, stack);
    },
  );
}
