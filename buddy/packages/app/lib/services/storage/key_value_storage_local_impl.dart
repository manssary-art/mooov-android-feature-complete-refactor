import 'package:core/core.dart';
import 'package:hive/hive.dart';

import 'key_value_storage.dart';

class KeyValueStorageLocalImpl implements KeyValueStorage {
  final Box<dynamic> box;

  KeyValueStorageLocalImpl(this.box);

  @override
  Future<bool> containsKey(String key) async {
    return box.containsKey(key);
  }

  @override
  Future<bool?> getBool(String key) async {
    return box.getTyped<bool?>(key);
  }

  @override
  Future<double?> getDouble(String key) async {
    return box.getTyped<double?>(key);
  }

  @override
  Future<int?> getInt(String key) async {
    return box.getTyped<int?>(key);
  }

  @override
  Future<String?> getString(String key) async {
    return box.getTyped<String?>(key);
  }

  @override
  Future<bool> remove(String key) async {
    await box.delete(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    await box.clear();
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    await box.put(key, value);
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    await box.put(key, value);
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    await box.put(key, value);
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    await box.put(key, value);
    return true;
  }

  @override
  Future<Set<String>> get keys async {
    return box.keys.mapNotNull<String>((e) => e is String ? e : null).toSet();
  }
}

extension HiveBoxExt on Box<dynamic> {
  T? getTyped<T>(String key) {
    final value = get(key);
    if (value is T) return value;
    return null;
  }
}
