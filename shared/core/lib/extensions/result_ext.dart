import 'dart:async';

import 'package:async/async.dart';

import '../core.dart';

part 'result_async_ext.dart';

extension ResultTExt<T> on T {
  ValueResult<T> asValueResult() {
    return ValueResult(this);
  }

  ErrorResult asErrorResult([StackTrace? stackTrace]) {
    return ErrorResult(this as Object, stackTrace);
  }
}

extension ResultTMethodExt<T> on Result<T> {
  Result<T> onValue(
    void Function(T) block,
  ) {
    final result = this;
    if (result is ValueResult<T>) {
      block(result.value);
    }

    return result;
  }

  Result<T> onError(
    void Function(Object, StackTrace?) block,
  ) {
    final result = this;
    if (result is ErrorResult) {
      block(result.error, result.stackTrace);
    }

    return result;
  }

  Result<T> onFinally(
    void Function() block,
  ) {
    block();
    return this;
  }

  Result<T2> mapValue<T2>(
    T2 Function(T) block,
  ) =>
      switch (this) {
        ValueResult<T> value => Result<T2>.value(block(value.value)),
        ErrorResult value => value,
        _ => throw AssertionError(),
      };

  Result<T> mapError(
    (Object, StackTrace?) Function(Object, StackTrace?) block,
  ) =>
      switch (this) {
        ValueResult<T> value => value,
        ErrorResult value => Result<T>.error(
            block(value.error, value.stackTrace),
          ),
        _ => throw AssertionError(),
      };

  Result<T2> flatMapValue<T2>(
    Result<T2> Function(T) block,
  ) =>
      switch (this) {
        ValueResult<T> value => block(value.value),
        ErrorResult value => value,
        _ => throw AssertionError(),
      };

  Result<T> flatMapError(
    Result<T> Function(Object, StackTrace?) block,
  ) =>
      switch (this) {
        ValueResult<T> value => value,
        ErrorResult value => block(value.error, value.stackTrace),
        _ => throw AssertionError(),
      };

  T2 fold<T2>({
    required T2 Function(T) onValue,
    required T2 Function(Object, StackTrace?) onError,
  }) =>
      switch (this) {
        ValueResult<T> value => onValue(value.value),
        ErrorResult value => onError(value.error, value.stackTrace),
        _ => throw AssertionError(),
      };
}
