class Clazz<T> {
  final Type type = T;

  bool isType<V>(V value) => value is T;

  @override
  bool operator ==(Object other) => (other is Clazz && other.type == type) || (other is Type && other == type);

  @override
  int get hashCode => type.hashCode;
}
