part of '_order_details_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<OrderDetailsSideEffect>.broadcast(),
).scoped(_scope);

sealed class OrderDetailsSideEffect {}

class OrderDetailsSideEffect$NavBack implements OrderDetailsSideEffect {
  const OrderDetailsSideEffect$NavBack();
}

class OrderDetailsSideEffect$NavToEditOrder implements OrderDetailsSideEffect {
  final String orderId;

  const OrderDetailsSideEffect$NavToEditOrder({required this.orderId});
}

class OrderDetailsSideEffect$NavToWorkerApplicationForm implements OrderDetailsSideEffect {
  const OrderDetailsSideEffect$NavToWorkerApplicationForm();
}

class OrderDetailsSideEffect$NavToAuthentication implements OrderDetailsSideEffect {
  const OrderDetailsSideEffect$NavToAuthentication();
}

class OrderDetailsSideEffect$ShareUrl implements OrderDetailsSideEffect {
  final String url;

  const OrderDetailsSideEffect$ShareUrl({required this.url});
}