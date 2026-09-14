part of '_order_rating_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<OrderRatingSideEffect>.broadcast(),
).scoped(_scope);

sealed class OrderRatingSideEffect {
  const OrderRatingSideEffect();
}

class OrderRatingSideEffect$NavBack extends OrderRatingSideEffect {
  const OrderRatingSideEffect$NavBack();
}

class OrderRatingSideEffect$ShowError extends OrderRatingSideEffect {
  const OrderRatingSideEffect$ShowError();
}
