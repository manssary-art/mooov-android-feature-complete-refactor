extension ListExt<T> on List<T> {
  List<T2> mapIndexed<T2>(T2 Function(int i, T e) block) {
    return asMap().map((key, value) => MapEntry<int, T2>(key, block(key, value))).values.toList();
  }

  List<T2> mapNotNullIndexed<T2>(T2? Function(int i, T e) block) {
    return asMap().entries.mapNotNull((e) => block(e.key, e.value)).toList();
  }

  List<T2> mapNotNull<T2>(T2? Function(T e) block) {
    return map((e) => block(e)).where((e) => e != null).cast<T2>().toList();
  }

  List<T2> flatMap<T2>(List<T2> Function(T e) block) {
    return map((e) => block(e)).expand((e) => e).toList();
  }

  List<T2> flatMapIndex<T2>(List<T2> Function(int i, T e) block) {
    return mapIndexed((i, e) => block(i, e)).expand((e) => e).toList();
  }

  T? getAtOrNull(int index) {
    return length > index && index >= 0 ? this[index] : null;
  }

  List<T> plus(T it) {
    final list = List<T>.of(this);
    list.add(it);
    return list;
  }

  List<T> plusAll(List<T> it) {
    final list = List<T>.of(this);
    list.addAll(it);
    return list;
  }

  List<T> minus(T it) {
    final list = List<T>.of(this);
    list.remove(it);
    return list;
  }

  List<T> minusAll(List<T> it) {
    final list = List<T>.of(this);
    list.removeWhere((e) => it.contains(e));
    return list;
  }

  List<T> minusAt(int it) {
    final list = List<T>.of(this);
    list.removeAt(it);
    return list;
  }

  List<T> minusWhere(bool Function(T) block) {
    final list = List<T>.of(this);
    list.removeWhere(block);
    return list;
  }

  List<T> replaceAtOrAdd(int index, T value) {
    final copy = toList();
    if (index > length - 1) {
      copy.add(value);
    } else {
      copy[index] = value;
    }
    return copy;
  }
}

extension ListNullableExt<T> on List<T?> {
  List<T> filterNotNull() {
    return where((e) => e != null).cast<T>().toList();
  }
}

extension IterableExt<T> on Iterable<T> {
  int get lastIndex => length - 1;

  Iterable<T2> mapIndexed<T2>(T2 Function(int i, T e) block) {
    return toList().mapIndexed(block);
  }

  Iterable<T2> mapNotNullIndexed<T2>(T2? Function(int i, T e) block) {
    return toList().mapNotNullIndexed(block);
  }

  Iterable<T2> mapNotNull<T2>(T2? Function(T e) block) {
    return map((e) => block(e)).where((e) => e != null).cast<T2>();
  }

  T? firstOrNull([bool Function(T e)? block]) {
    if (isEmpty) return null;
    final whereBlock = block ?? (e) => e != null;
    for (final e in this) {
      if (whereBlock(e)) {
        return e;
      }
    }
    return null;
  }

  Map<K, T> associateBy<K>(K Function(T e) block) {
    return Map<K, T>.fromIterable(this, key: (e) => block(e));
  }

  List<T> containsDifference(List<T> other) {
    List<T> output = [];
    for (final element in this) {
      if (!other.contains(element)) {
        output.add(element);
      }
    }

    return other;
  }

  List<T> sorted<V>(int Function(T a, T b) block) {
    final newList = List.of(this);
    newList.sort(block);
    return newList;
  }
}
