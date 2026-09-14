part of '_authentication_providers.dart';

final sideEffectProvider = Provider(
  name: '$_name.sideEffectProvider',
  dependencies: _scope.dependencies,
  (ref) => StreamController<AuthenticationSideEffect>.broadcast(),
).scoped(_scope);

sealed class AuthenticationSideEffect {}

class AuthenticationSideEffect$NavBack implements AuthenticationSideEffect {
  const AuthenticationSideEffect$NavBack();
}

class AuthenticationSideEffect$NavToCountryPicker implements AuthenticationSideEffect {
  final Country initial;
  const AuthenticationSideEffect$NavToCountryPicker(this.initial);
}
