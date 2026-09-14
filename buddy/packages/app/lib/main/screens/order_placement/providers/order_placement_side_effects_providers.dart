part of '_order_placement_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<OrderPlacementSideEffect>.broadcast(),
).scoped(_scope);

sealed class OrderPlacementSideEffect {}

class OrderPlacementSideEffect$NavBack implements OrderPlacementSideEffect {
  const OrderPlacementSideEffect$NavBack();
}

class OrderPlacementSideEffect$NavToImagePicker implements OrderPlacementSideEffect {
  final String key;

  const OrderPlacementSideEffect$NavToImagePicker(this.key);
}

class OrderPlacementSideEffect$NavToAddressPicker implements OrderPlacementSideEffect {
  final int key;

  const OrderPlacementSideEffect$NavToAddressPicker(this.key);
}
