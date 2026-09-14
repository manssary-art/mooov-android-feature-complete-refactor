part of '_order_payment_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<OrderPaymentSideEffect>.broadcast(),
).scoped(_scope);



sealed class OrderPaymentSideEffect {}

class OrderPaymentSideEffect$NavBack implements OrderPaymentSideEffect {
  final bool success;
  const OrderPaymentSideEffect$NavBack(this.success);
}

class OrderPaymentSideEffect$NavToCardPayment implements OrderPaymentSideEffect {
  final PaymentIntentModel intent;
  const OrderPaymentSideEffect$NavToCardPayment(this.intent);
}
