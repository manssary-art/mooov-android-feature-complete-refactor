part of 'result_ext.dart';

void Function(Object, StackTrace?) resultOfHooks = (_, __) {};

Future<Result<T>> resultOf<T>(
  FutureOr<Result<T>> Function() block,
) async {
  try {
    return await block();
  } catch (e, s) {
    resultOfHooks(e, s);
    return Result.error(e, s);
  }
}

extension AsyncResultTExt<T> on Future<T> {
  Future<ValueResult<T>> asValueResult() async {
    return (await this).asValueResult();
  }

  Future<ErrorResult> asErrorResult([StackTrace? stackTrace]) async {
    return (await this).asErrorResult(stackTrace);
  }
}

extension AsyncResultTAttExt<T> on Future<Result<T>> {
  Future<ValueResult<T>?> get asValue async => (await this).asValue;

  Future<ErrorResult?> get asError async => (await this).asError;
}

extension AsyncValueResultTAttExt<T> on Future<ValueResult<T>?> {
  Future<T?> get value async => (await this)?.value;
}

extension AsyncErrorResultTAttExt<T> on Future<ErrorResult?> {
  Future<Object?> get error async => (await this)?.error;

  Future<StackTrace?> get stackTrace async => (await this)?.stackTrace;
}

extension AsyncResultTMethodExt<T> on Future<Result<T>> {
  Future<Result<T>> onValue(
    FutureOr<void> Function(T) block,
  ) async {
    final result = await this;
    if (result is ValueResult<T>) {
      await block(result.value);
    }

    return result;
  }

  Future<Result<T>> onError(
    FutureOr<void> Function(Object, StackTrace?) block,
  ) async {
    final result = await this;
    if (result is ErrorResult) {
      await block(result.error, result.stackTrace);
    }

    return result;
  }

  Future<Result<T>> onFinally(
    FutureOr<void> Function() block,
  ) async {
    await block();
    return this;
  }

  Future<Result<T2>> mapValue<T2>(
    FutureOr<T2> Function(T) block,
  ) async =>
      switch (await this) {
        ValueResult<T> value => Result<T2>.value(await block(value.value)),
        ErrorResult value => value,
        _ => throw AssertionError(),
      };

  Future<Result<T>> mapError(
    FutureOr<(Object, StackTrace?)> Function(Object, StackTrace?) block,
  ) async =>
      switch (await this) {
        ValueResult<T> value => value,
        ErrorResult value => Result<T>.error(
            await block(value.error, value.stackTrace),
          ),
        _ => throw AssertionError(),
      };

  Future<Result<T2>> flatMapValue<T2>(
    FutureOr<Result<T2>> Function(T) block,
  ) async =>
      switch (await this) {
        ValueResult<T> value => await block(value.value),
        ErrorResult value => value,
        _ => throw AssertionError(),
      };

  Future<Result<T>> flatMapError(
    FutureOr<Result<T>> Function(Object, StackTrace?) block,
  ) async =>
      switch (await this) {
        ValueResult<T> value => value,
        ErrorResult value => await block(value.error, value.stackTrace),
        _ => throw AssertionError(),
      };

  Future<T2> fold<T2>({
    required FutureOr<T2> Function(T) onValue,
    required FutureOr<T2> Function(Object, StackTrace?) onError,
  }) async =>
      switch (await this) {
        ValueResult<T> value => await onValue(value.value),
        ErrorResult value => await onError(value.error, value.stackTrace),
        _ => throw AssertionError(),
      };
}
