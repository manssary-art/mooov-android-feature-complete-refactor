import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/riverpod_ext.dart';
import 'providers/_authentication_providers.dart';
import 'widgets/content/authentication_screen_content.dart';

class AuthenticationScreen extends HookConsumerWidget {
  final VoidCallback onNavBack;
  final Future<Country?> Function(Country initial) onNavToCountryPicker;

  const AuthenticationScreen({
    super.key,
    required this.onNavBack,
    required this.onNavToCountryPicker,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialNotifier = ref.watch(authenticationProvider.notifier);
    final initial = ref.watch(authenticationProvider);
    final sideEffect = ref.watch(sideEffectProvider);
    final countryNotifier = ref.watch(countryProvider.notifier);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case AuthenticationSideEffect$NavBack():
            onNavBack();
            break;
          case AuthenticationSideEffect$NavToCountryPicker():
            final country = await onNavToCountryPicker(effect.initial);
            if (country != null) countryNotifier.onCountryPicked(country);
            break;
        }
      }).cancel,
      [sideEffect],
    );

    final country = ref.watch(countryProvider);
    final isWorking = ref.watch(isWorkingProvider);
    final phoneNumber = ref.watch(phoneNumberProvider);
    final phoneNumberNotifier = ref.watch(phoneNumberProvider.notifier);
    final smsCode = ref.watch(verificationCodeProvider);
    final smsCodeNotifier = ref.watch(verificationCodeProvider.notifier);
    final firstName = ref.watch(firstNameProvider);
    final firstNameNotifier = ref.watch(firstNameProvider.notifier);
    final lastName = ref.watch(lastNameProvider);
    final lastNameNotifier = ref.watch(lastNameProvider.notifier);
    final email = ref.watch(emailProvider);
    final emailNotifier = ref.watch(emailProvider.notifier);
    final authStep = initial;
    return AuthenticationScreenContent(
      authStep: authStep,
      country: country,
      phoneNumber: phoneNumber,
      smsCode: smsCode,
      firstName: firstName,
      lastName: lastName,
      email: email,
      isWorking: isWorking,
      isSubmitInfoEnabled: firstName.isNotEmpty && lastName.isNotEmpty,
      isSendCodeEnabled: phoneNumber.length > 6,
      isSubmitCodeEnabled: smsCode.length == 6,
      onPhoneNumberChanged: phoneNumberNotifier.onValueChanged,
      onSmsCodeChanged: smsCodeNotifier.onValueChanged,
      onFirstNameChanged: firstNameNotifier.onValueChanged,
      onLastNameChanged: lastNameNotifier.onValueChanged,
      onEmailChanged: emailNotifier.onValueChanged,
      onNavBackClicked: initialNotifier.onNavBackClicked,
      onPickCountryClicked: countryNotifier.onPickCountryClicked,
      onSendCodeClicked: initialNotifier.onSendCodeClicked,
      onSubmitCodeClicked: initialNotifier.onSubmitCodeClicked,
      onSubmitInfoClicked: initialNotifier.onSubmitInfoClicked,
    );
  }
}
