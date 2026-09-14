import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../health/health_monitor_exception_mixin.dart';
import '../health/riverpod_observer.dart';

Future platformBootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);

  FlutterError.onError = (errorDetails) async {
    logger.e("FlutterError.onError", errorDetails.exceptionAsString(), errorDetails.stack);
    if (kReleaseMode) {
      final exception = errorDetails.exception;
      if (exception is HealthMonitorExceptionMixin) {
        await exception.setKeys();
      }
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e("PlatformDispatcher.onError", error, stack);
    if (kReleaseMode) {
      Future.microtask(() async {
        if (error is HealthMonitorExceptionMixin) {
          await error.setKeys();
        }
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
      });
    }
    return true;
  };

  resultOfHooks = (error, stack) async {
    logger.e("resultOf.onError", error, stack);
    if (kReleaseMode) {
      if (error is HealthMonitorExceptionMixin) {
        await error.setKeys();
      }
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
    }
  };

  RiverpodObserver.onError = (name, error, stack) async {
    logger.e("Riverpod.onError", error, stack);
    if (kReleaseMode) {
      if (error is HealthMonitorExceptionMixin) {
        await error.setKeys();
      }
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
    }
  };

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

extension on HealthMonitorExceptionMixin {
  Future<void> setKeys() async {
    for (final entry in keys.entries) {
      try {
        await FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value ?? '');
      } catch (e) {
        // Nothing to do
      }
    }
  }
}
