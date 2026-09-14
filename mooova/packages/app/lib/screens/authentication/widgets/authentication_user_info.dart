import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/extensions/material_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import 'authentication_text_field.dart';

class AuthenticationUserInfoContent extends HookWidget {
  final String firstName;
  final String lastName;
  final String email;
  final bool isSubmitInfoEnabled;
  final ValueSetter<String> onFirstNameChanged;
  final ValueSetter<String> onLastNameChanged;
  final ValueSetter<String> onEmailChanged;
  final VoidCallback onSubmitInfoClicked;

  const AuthenticationUserInfoContent({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isSubmitInfoEnabled,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onEmailChanged,
    required this.onSubmitInfoClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildFirstLastName(
          context: context,
          firstName: firstName,
          lastName: lastName,
          onFirstNameChanged: onFirstNameChanged,
          onLastNameChanged: onLastNameChanged,
        ),
        const SizedBox(height: 16),
        AuthenticationTextField(
          name: 'email',
          value: email,
          hintText: LocaleKeys.EmailOptional.tr(),
          keyboardType: TextInputType.emailAddress,
          onChanged: onEmailChanged,
        ),
        const SizedBox(height: 24),
        buildSubmitInfoButton(
          context: context,
          isSubmitInfoEnabled: isSubmitInfoEnabled,
          onSubmitInfoClicked: onSubmitInfoClicked,
        )
      ],
    );
  }

  static Widget buildFirstLastName({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required ValueSetter<String> onFirstNameChanged,
    required ValueSetter<String> onLastNameChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: AuthenticationTextField(
            name: 'firstName',
            value: firstName,
            inputFormatters: [FilteringTextInputFormatters.notDigits],
            hintText: LocaleKeys.Firstname.tr(),
            keyboardType: TextInputType.name,
            onChanged: onFirstNameChanged,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AuthenticationTextField(
            name: 'lastName',
            value: lastName,
            inputFormatters: [FilteringTextInputFormatters.notDigits],
            hintText: LocaleKeys.Lastname.tr(),
            keyboardType: TextInputType.name,
            onChanged: onLastNameChanged,
          ),
        ),
      ],
    );
  }

  static Widget buildSubmitInfoButton({
    required BuildContext context,
    required bool isSubmitInfoEnabled,
    required VoidCallback onSubmitInfoClicked,
  }) {
    return FilledButton(
      style: Theme.of(context).filledButtonTheme.style?.copyWith(
            minimumSize: const Size.fromHeight(48).asMSP,
            backgroundColor: Theme.of(context).colorScheme.background.asMSP,
            foregroundColor: Theme.of(context).colorScheme.onBackground.asMSP,
          ),
      onPressed: onSubmitInfoClicked.takeIf((_) => isSubmitInfoEnabled),
      child: Text(LocaleKeys.CreateAccount.tr()),
    );
  }
}
