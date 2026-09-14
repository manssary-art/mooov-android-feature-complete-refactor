import 'dart:async';

import 'package:async/async.dart';

class CancelledException implements Exception {}

class CancelableOperations {
  final _map = <String, CancelableOperation>{};

  void put<T>(String key, CancelableOperation<T> value) {
    _map[key]?.cancel();
    _map[key] = value;
  }

  Future<dynamic> cancel(String key) async {
    return await _map[key]?.cancel();
  }

  Future<dynamic> cancelAll() async {
    await Future.wait(_map.values.map((e) => e.cancel()));
  }

  CancelableOperation? get<T>(String key) {
    return _map[key];
  }

  CancelableOperation? operator [](String key) => get(key);

  void operator []=(String key, CancelableOperation value) => put(key, value);
}

extension FutureExt<T> on Future<T> {
  CancelableOperation<T> asCancelable({FutureOr Function()? onCancel}) {
    final cancellable = CancelableCompleter<T>(onCancel: onCancel);
    cancellable.complete(this);
    return cancellable.operation;
  }
}

extension CancelableOperationExt<T> on CancelableOperation {
  static dynamic cancellationToken = Object();

  Future<Result<T>> asResult() async {
    final result = await valueOrCancellation(cancellationToken);
    if (result == cancellationToken) {
      return Result<T>.error(CancelledException(), StackTrace.current);
    }
    return Result<T>.value(result);
  }
}
