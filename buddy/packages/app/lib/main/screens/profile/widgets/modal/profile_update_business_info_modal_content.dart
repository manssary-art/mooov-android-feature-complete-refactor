import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/user_model.dart';

typedef ProfileUpdateBusinessInfo$SubmitData = ({
  String companyName,
  String companyVat,
  String companyAddress,
  String email,
});

class ProfileUpdateBusinessInfoModalContent extends HookWidget {
  final UserModel user;
  final bool isWorking;
  final void Function() onNavBackClicked;
  final void Function(ProfileUpdateBusinessInfo$SubmitData) onSubmitClicked;

  const ProfileUpdateBusinessInfoModalContent({
    super.key,
    required this.user,
    required this.isWorking,
    required this.onNavBackClicked,
    required this.onSubmitClicked,
  });

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(color: Colors.white);
    final companyNameController = useTextEditingController(text: user.businessInfo?.name ?? '');
    final companyVatController = useTextEditingController(text: user.businessInfo?.vatNumber ?? '');
    final companyAddressController = useTextEditingController(text: user.businessInfo?.address ?? '');
    final companyEmailController = useTextEditingController(text: user.email ?? '');
    return Center(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF6382FF),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: Assets.images.iconPencilCoffeePaper.image(
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(LocaleKeys.CompanyInfo.tr()),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: FormBuilderTextField(
                      controller: companyNameController,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: LocaleKeys.CompanyName.tr(),
                        focusedBorder: const UnderlineInputBorder(borderSide: borderSide),
                        enabledBorder: const UnderlineInputBorder(borderSide: borderSide),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      maxLines: 1,
                      name: 'textfield',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: FormBuilderTextField(
                      controller: companyVatController,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: LocaleKeys.CompanyVAT.tr(),
                        focusedBorder: const UnderlineInputBorder(borderSide: borderSide),
                        enabledBorder: const UnderlineInputBorder(borderSide: borderSide),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      maxLines: 1,
                      name: 'textfield',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: FormBuilderTextField(
                      controller: companyAddressController,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: LocaleKeys.CompanyAddress.tr(),
                        focusedBorder: const UnderlineInputBorder(borderSide: borderSide),
                        enabledBorder: const UnderlineInputBorder(borderSide: borderSide),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      maxLines: 1,
                      name: 'textfield',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: FormBuilderTextField(
                      controller: companyEmailController,
                      textCapitalization: TextCapitalization.none,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      cursorColor: Colors.white,
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) => TextEditingValue(
                            text: newValue.text.toLowerCase(),
                            selection: newValue.selection,
                          ),
                        )
                      ],
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: LocaleKeys.CompanyEmail.tr(),
                        focusedBorder: const UnderlineInputBorder(borderSide: borderSide),
                        enabledBorder: const UnderlineInputBorder(borderSide: borderSide),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      maxLines: 1,
                      name: 'textfield',
                    ),
                  ),
                  const SizedBox(height: 24),
                  HookBuilder(
                    builder: (context) {
                      final companyName = useValueListenable(companyNameController);
                      final companyVat = useValueListenable(companyVatController);
                      final companyAddress = useValueListenable(companyAddressController);
                      final companyEmail = useValueListenable(companyEmailController);
                      final isSubmitEnabled = !isWorking && companyName.text.isNotEmpty &&
                          companyVat.text.isNotEmpty &&
                          companyAddress.text.isNotEmpty &&
                          companyEmail.text.isNotEmpty &&
                          companyEmail.text.isValidEmail;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: FilledButton(
                          onPressed: isSubmitEnabled
                              ? () => onSubmitClicked((
                                    companyAddress: companyAddress.text,
                                    companyName: companyName.text,
                                    companyVat: companyVat.text,
                                    email: companyEmail.text,
                                  ))
                              : null,
                          child: let(() {
                            if (isWorking) {
                              return const LoadingIndicator(
                                color: Colors.white,
                              );
                            }

                            return Text(LocaleKeys.UpgradeToBusiness.tr());
                          }),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned(
            right: 32,
            top: 32,
            child: Clickable(
              onTap: onNavBackClicked.takeIf((it) => !isWorking),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
