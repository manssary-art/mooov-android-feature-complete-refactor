import '../core.dart';

extension MapExt<K, V> on Map<K, V> {
  Map<K, V> plus(K key, V value) {
    return Map.of(this).also((it) => it[key] = value);
  }

  Map<K, V2> mapValues<V2>(V2 Function(K key, V value) block) {
    return map<K, V2>((key, value) => MapEntry<K, V2>(key, block(key, value)));
  }

  Map<K2, V> mapKeys<K2>(K2 Function(K key, V value) block) {
    return map<K2, V>((key, value) => MapEntry<K2, V>(block(key, value), value));
  }

  V getOrPut(K key, V Function() block) {
    if (!containsKey(key)) {
      this[key] = block();
    }
    return this[key]!;
  }

  V getOrDefault(K key, V Function() block) {
    if (!containsKey(key)) {
      return block();
    }
    return this[key]!;
  }

  Map<K, V> copy() {
    return Map<K, V>.of(this);
  }

  Map<K2, V2> mapNotNull<K2, V2>(
    MapEntry<K2, V2>? Function(K key, V value) block,
  ) {
    return Map<K2, V2>.fromEntries(entries.mapNotNull<MapEntry<K2, V2>>((e) => block(e.key, e.value)));
  }
}
