import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import '../health/riverpod_observer.dart';
import 'firebase/load_firebase_options_web.dart';

Future platformBootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final options = await loadFirebaseOptions();
  await Firebase.initializeApp(options: options);
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  FlutterError.onError = (errorDetails) {
    logger.e("FlutterError.onError", errorDetails.exceptionAsString(), errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e("PlatformDispatcher.onError", error, stack);
    return true;
  };

  resultOfHooks = (error, stack) {
    logger.e("resultOf.onError", error, stack);
  };

  RiverpodObserver.onError = (name, error, stack) {
    logger.e("Riverpod.onError $name", error, stack);
  };

  // remove the leading hash (#) from URL
  setPathUrlStrategy();
}
