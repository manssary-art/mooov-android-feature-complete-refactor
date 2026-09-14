import 'dart:async';

T let<T>(T Function() block) {
  return block();
}

extension KObjectExt<T> on T {
  T2 let<T2>(T2 Function(T it) block) {
    return block(this);
  }

  T also(void Function(T it) block) {
    block(this);
    return this;
  }

  void run(void Function(T it) block) {
    block(this);
  }

  T? takeIf(bool Function(T it) block) {
    return block(this) ? this : null;
  }

  T2? takeIfType<T2>() {
    return this is T2 ? this as T2 : null;
  }

  List<T>? toSingleElementList() {
    return this?.let((it) => [it]);
  }
}

extension KFutureObjectExt<T> on Future<T> {
  Future<T2> let<T2>(T2 Function(T it) block) {
    return this.then((value) => value.let((it) => block(it)));
  }

  Future<T> also(void Function(T it) block) {
    this.then((value) => value.also((it) => block(it)));
    return this;
  }

  Future<T?> takeIf(bool Function(T it) block) {
    return this.then((value) => value.takeIf((it) => block(it)));
  }

  Future<T2?> takeIfType<T2>() {
    return this.then((value) => value.takeIfType());
  }
}
