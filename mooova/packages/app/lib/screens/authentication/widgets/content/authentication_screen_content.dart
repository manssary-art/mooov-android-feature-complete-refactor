import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../models/auth_step.dart';
import '../authentication_header.dart';
import '../authentication_phone_number.dart';
import '../authentication_user_info.dart';

class AuthenticationScreenContent extends HookWidget {
  final AuthStep authStep;
  final Country country;
  final String phoneNumber;
  final String smsCode;
  final String firstName;
  final String lastName;
  final String email;
  final bool isWorking;
  final bool isSubmitInfoEnabled;
  final bool isSendCodeEnabled;
  final bool isSubmitCodeEnabled;
  final ValueSetter<String> onPhoneNumberChanged;
  final ValueSetter<String> onSmsCodeChanged;
  final ValueSetter<String> onFirstNameChanged;
  final ValueSetter<String> onLastNameChanged;
  final ValueSetter<String> onEmailChanged;
  final VoidCallback onNavBackClicked;
  final VoidCallback onPickCountryClicked;
  final VoidCallback onSendCodeClicked;
  final VoidCallback onSubmitCodeClicked;
  final VoidCallback onSubmitInfoClicked;

  const AuthenticationScreenContent({
    super.key,
    required this.authStep,
    required this.country,
    required this.phoneNumber,
    required this.smsCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isWorking,
    required this.isSubmitInfoEnabled,
    required this.isSendCodeEnabled,
    required this.isSubmitCodeEnabled,
    required this.onPhoneNumberChanged,
    required this.onSmsCodeChanged,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onEmailChanged,
    required this.onNavBackClicked,
    required this.onPickCountryClicked,
    required this.onSendCodeClicked,
    required this.onSubmitCodeClicked,
    required this.onSubmitInfoClicked,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onNavBackClicked();
        return false;
      },
      child: LoadingOverlay(
        isVisible: isWorking,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: ResponsiveBreakpoints.of(context).breakpointOfOrNull(MOBILE)?.end ?? 450,
                      ),
                      child: Column(
                        children: [
                          AuthenticationHeaderContent(
                            authStep: authStep,
                          ),
                          const SizedBox(height: 24),
                          Container(
                            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.2),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: authStep == AuthStep.enterInfo
                                      ? AuthenticationUserInfoContent(
                                          firstName: firstName,
                                          lastName: lastName,
                                          email: email,
                                          isSubmitInfoEnabled: isSubmitInfoEnabled,
                                          onFirstNameChanged: onFirstNameChanged,
                                          onLastNameChanged: onLastNameChanged,
                                          onEmailChanged: onEmailChanged,
                                          onSubmitInfoClicked: onSubmitInfoClicked,
                                        )
                                      : AuthenticationPhoneNumberContent(
                                          authStep: authStep,
                                          country: country,
                                          phoneNumber: phoneNumber,
                                          smsCode: smsCode,
                                          isSendCodeEnabled: isSendCodeEnabled,
                                          isSubmitCodeEnabled: isSubmitCodeEnabled,
                                          onPhoneNumberChanged: onPhoneNumberChanged,
                                          onSmsCodeChanged: onSmsCodeChanged,
                                          onPickCountryClicked: onPickCountryClicked,
                                          onSendCodeClicked: onSendCodeClicked,
                                          onSubmitCodeClicked: onSubmitCodeClicked,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Assets.images.imageAuthBackgroud.image(
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
