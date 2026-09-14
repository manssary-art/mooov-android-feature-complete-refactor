part of '_authentication_providers.dart';

final countryProvider = NotifierProvider<AuthenticationCountryNotifier, Country>(
  name: '$_name.countryProvider',
  dependencies: _scope.dependencies,
  () => AuthenticationCountryNotifier(),
).scoped(_scope);

class AuthenticationCountryNotifier extends Notifier<Country> {
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  Country build() {
    return Country.SE;
  }

  void onPickCountryClicked() async {
    _sideEffect().add(AuthenticationSideEffect$NavToCountryPicker(state));
  }

  void onCountryPicked(Country country) async {
    state = country;
  }
}
