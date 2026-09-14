import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/extensions/material_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/auth_step.dart';
import 'authentication_text_field.dart';

class AuthenticationPhoneNumberContent extends HookWidget {
  final AuthStep authStep;
  final Country country;
  final String phoneNumber;
  final String smsCode;
  final bool isSendCodeEnabled;
  final bool isSubmitCodeEnabled;
  final VoidCallback onPickCountryClicked;
  final VoidCallback onSendCodeClicked;
  final VoidCallback onSubmitCodeClicked;
  final ValueSetter<String> onPhoneNumberChanged;
  final ValueSetter<String> onSmsCodeChanged;

  const AuthenticationPhoneNumberContent({
    super.key,
    required this.authStep,
    required this.country,
    required this.phoneNumber,
    required this.smsCode,
    required this.isSendCodeEnabled,
    required this.isSubmitCodeEnabled,
    required this.onPhoneNumberChanged,
    required this.onSmsCodeChanged,
    required this.onPickCountryClicked,
    required this.onSendCodeClicked,
    required this.onSubmitCodeClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Clickable(
                onTap: onPickCountryClicked,
                child: Row(
                  children: [
                    Assets.images.iconFoldArrowDownWhite.image(width: 20, height: 20),
                    const SizedBox(width: 4),
                    country.asset.image(width: 28, height: 28),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('(${country.dialCode})'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AuthenticationTextField(
                name: 'phoneNumber',
                value: phoneNumber,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: onPhoneNumberChanged,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (authStep == AuthStep.enterPhoneNumber) ...[
          FilledButton(
            style: Theme.of(context).filledButtonTheme.style?.copyWith(
                  minimumSize: const Size.fromHeight(48).asMSP,
                  backgroundColor: Theme.of(context).colorScheme.background.asMSP,
                  foregroundColor: Theme.of(context).colorScheme.onBackground.asMSP,
                ),
            onPressed: onSendCodeClicked.takeIf((_) => isSendCodeEnabled),
            child: Text(LocaleKeys.SendCode.tr()),
          ),
        ],
        if (authStep == AuthStep.enterVerificationCode) ...[
          Row(
            children: [
              Expanded(
                child: AuthenticationTextField(
                  name: 'smsCode',
                  value: smsCode,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: LocaleKeys.EnterCode.tr(),
                  keyboardType: TextInputType.number,
                  onChanged: (e) => onSmsCodeChanged(e),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: FilledButton(
                  style: Theme.of(context).filledButtonTheme.style?.copyWith(
                        minimumSize: const Size.fromHeight(28).asMSP,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)).asMSP,
                        backgroundColor: Theme.of(context).colorScheme.background.asMSP,
                        foregroundColor: Theme.of(context).colorScheme.onBackground.asMSP,
                      ),
                  onPressed: onSendCodeClicked,
                  child: Text(LocaleKeys.Resend.tr()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: Theme.of(context).filledButtonTheme.style?.copyWith(
                  minimumSize: const Size.fromHeight(48).asMSP,
                  backgroundColor: Theme.of(context).colorScheme.background.asMSP,
                  foregroundColor: Theme.of(context).colorScheme.onBackground.asMSP,
                ),
            onPressed: onSubmitCodeClicked.takeIf((_) => isSubmitCodeEnabled),
            child: Text(LocaleKeys.EnterCode.tr()),
          ),
        ]
      ],
    );
  }
}
