class Disposables {
  final _map = <String, Function()>{};

  void put(String key, Function() block) {
    _map[key]?.call();
    _map[key] = block;
  }

  Function()? operator [](String key) => _map[key];

  void operator []=(String key, Function() value) => put(key, value);

  void dispose() {
    _map.removeWhere((key, value) {
      value();
      return true;
    });
  }
}
