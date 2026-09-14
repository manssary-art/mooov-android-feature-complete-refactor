part of '_authentication_providers.dart';

final isWorkingProvider = StateProvider<bool>(
  name: '$_name.isWorkingProvider',
  dependencies: _scope.dependencies,
  (ref) => false,
).scoped(_scope);

final phoneNumberProvider = StateProvider<String>(
  name: '$_name.phoneNumberProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final verificationCodeProvider = StateProvider<String>(
  name: '$_name.verificationCodeProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final firstNameProvider = StateProvider<String>(
  name: '$_name.firstNameProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final lastNameProvider = StateProvider<String>(
  name: '$_name.lastNameProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);

final emailProvider = StateProvider<String>(
  name: '$_name.emailProvider',
  dependencies: _scope.dependencies,
  (ref) => '',
).scoped(_scope);
