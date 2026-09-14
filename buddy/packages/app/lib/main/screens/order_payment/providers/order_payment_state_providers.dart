part of '_order_payment_providers.dart';

final isWorkingProvider = StateProvider<bool>(
  name: '$_name.isWorkingProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);

final stepProvider = StateProvider<OrderPaymentStep>(
  name: '$_name.stepProvider',
  dependencies: _scope.dependencies,
  (ref) => OrderPaymentStep.selectedMethod,
).scoped(_scope);

final promoCodeProvider = StateProvider<String>(
  name: '$_name.promoCodeProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final cardNumberProvider = StateProvider<String>(
  name: '$_name.cardNumberProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final cardExpirationYearProvider = StateProvider<int?>(
  name: '$_name.cardExpirationYearProvider',
  dependencies: _scope.dependencies,
  (ref) => null,
).scoped(_scope);

final cardExpirationMonthProvider = StateProvider<int?>(
  name: '$_name.cardExpirationMonthProvider',
  dependencies: _scope.dependencies,
  (ref) => null,
).scoped(_scope);

final cardCVCProvider = StateProvider<String>(
  name: '$_name.cardCVCProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final saveCardProvider = StateProvider<bool>(
  name: '$_name.saveCardProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);
