import 'package:hive_flutter/hive_flutter.dart';

class PreviewStorage {
  static late final Box<dynamic> storage;
  static const boxName = 'PreviewApp';
  static const screenKey = 'ScreenKey';

  static Future<void> ensureInitialized() async {
    await Hive.initFlutter();
    storage = await Hive.openBox(PreviewStorage.screenKey);
  }
}

extension PreviewStorageHiveBoxExt on Box<dynamic> {
  T? getTyped<T>(String key) {
    final value = get(key);
    if (value is T) return value;
    return null;
  }
}
