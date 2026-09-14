import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../../../core/riverpod_ext.dart';
import '../models/auth_step.dart';
import '../widgets/content/authentication_screen_content.dart';

class AuthenticationScreenPreview extends HookWidget with PreviewMixin {
  AuthenticationScreenPreview({
    super.key,
  });

  @override
  String get name => 'AuthenticationScreen';

  @override
  Widget build(BuildContext context) {
    final steps = AuthStep.values.associateBy((e) => e.name);
    final authStep = usePreviewOptions('AuthStep', steps.keys.toList()).let((it) => steps[it]!);
    final country = useState(Country.SE);
    final phoneNumber = useState('');
    final smsCode = useState('');
    final firstName = useState('');
    final lastName = useState('');
    final email = useState('');
    return AuthenticationScreenContent(
      authStep: authStep,
      country: country.value,
      phoneNumber: phoneNumber.value,
      smsCode: smsCode.value,
      firstName: firstName.value,
      lastName: lastName.value,
      email: email.value,
      isWorking: false,
      isSubmitInfoEnabled: firstName.value.isNotEmpty && lastName.value.isNotEmpty,
      isSendCodeEnabled: phoneNumber.value.length > 6,
      isSubmitCodeEnabled: smsCode.value.length == 6,
      onPhoneNumberChanged: phoneNumber.onValueChanged,
      onSmsCodeChanged: smsCode.onValueChanged,
      onFirstNameChanged: firstName.onValueChanged,
      onLastNameChanged: lastName.onValueChanged,
      onEmailChanged: email.onValueChanged,
      onNavBackClicked: () {},
      onPickCountryClicked: () => country.value = Country.values[Random().nextInt(Country.values.length)],
      onSendCodeClicked: () {},
      onSubmitCodeClicked: () {},
      onSubmitInfoClicked: () {},
    );
  }
}
