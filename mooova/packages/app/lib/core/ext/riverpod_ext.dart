import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderScopeContainer {
  final _dependencies = <ProviderBase>{};

  Iterable<ProviderBase> get dependencies => _dependencies;
}

extension ProviderScopesProviderBase<T extends ProviderBase> on T {
  T scoped(ProviderScopeContainer scope) {
    scope._dependencies.add(this);
    return this;
  }
}

extension RiverpodStateNotifierExt<T> on StateNotifier<T> {
  void onValueChanged(T value) {
    state = value;
  }
}

extension RiverpodNotifierExt<T> on Notifier<T> {
  void onValueChanged(T value) {
    state = value;
  }
}

extension RiverpodValueNotifierExt<T> on ValueNotifier<T> {
  void onValueChanged(T value) {
    this.value = value;
  }
}

/// An extension on [Ref] with helpful methods to add a debounce.
extension RefDebounceExtension on Ref {
  /// Delays an execution by a bit such that if a dependency changes multiple
  /// time rapidly, the rest of the code is only run once.
  Future<void> debounce(Duration duration) {
    final completer = Completer<void>();
    final timer = Timer(duration, () {
      if (!completer.isCompleted) completer.complete();
    });
    onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) {
        completer.completeError(DebounceCancellationException());
      }
    });
    return completer.future;
  }
}

class DebounceCancellationException implements Exception {
  @override
  String toString() => 'DebounceCancellationException()';
}
