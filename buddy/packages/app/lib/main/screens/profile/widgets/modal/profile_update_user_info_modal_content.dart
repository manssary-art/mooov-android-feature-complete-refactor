import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/user_model.dart';

typedef ProfileUpdateUserInfo$SubmitData = ({
  String firstName,
  String lastName,
  XFile? pickedImage,
  String email,
});

class ProfileUpdateUserInfoModalContent extends HookWidget {
  final UserModel user;
  final bool isWorking;
  final XFile? pickedImage;
  final void Function() onNavBackClicked;
  final void Function() onPickImageClicked;
  final void Function(ProfileUpdateUserInfo$SubmitData) onSubmitClicked;

  const ProfileUpdateUserInfoModalContent({
    super.key,
    required this.user,
    required this.isWorking,
    required this.pickedImage,
    required this.onNavBackClicked,
    required this.onPickImageClicked,
    required this.onSubmitClicked,
  });

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(color: Colors.grey);
    final firstNameController = useTextEditingController(text: user.firstName ?? '');
    final lastNameController = useTextEditingController(text: user.lastName ?? '');
    final emailController = useTextEditingController(text: user.email ?? '');
    return Center(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Clickable(
                          onTap: onPickImageClicked.takeIf((it) => !isWorking),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(120 / 8)),
                            child: let(() {
                              if (pickedImage != null) {
                                return Image(
                                  image: XFileImageProvider(pickedImage!),
                                  width: 120,
                                  height: 120,
                                );
                              }

                              return CachedNetworkImage(
                                imageUrl: user.image ?? '',
                                width: 120,
                                height: 120,
                                progressIndicatorBuilder: (_, __, ___) => Assets.images.iconLegoGuy.image(
                                  width: 120,
                                  height: 120,
                                ),
                                errorWidget: (_, __, ___) => Assets.images.iconLegoGuy.image(
                                  width: 120,
                                  height: 120,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: FormBuilderTextField(
                      controller: firstNameController,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: LocaleKeys.Firstname.tr(),
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
                      controller: lastNameController,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintMaxLines: 1,
                        hintText: LocaleKeys.Lastname.tr(),
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
                      controller: emailController,
                      textCapitalization: TextCapitalization.none,
                      autofocus: false,
                      enabled: !isWorking,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                      cursorColor: Colors.grey,
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
                        hintText: LocaleKeys.Email.tr(),
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
                      final firstName = useValueListenable(firstNameController);
                      final lastName = useValueListenable(lastNameController);
                      final userEmail = useValueListenable(emailController);
                      final isSubmitEnabled = !isWorking &&
                          firstName.text.isNotEmpty &&
                          lastName.text.isNotEmpty &&
                          userEmail.text.isNotEmpty &&
                          userEmail.text.isValidEmail;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: FilledButton(
                          onPressed: isSubmitEnabled
                              ? () => onSubmitClicked((
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    pickedImage: pickedImage,
                                    email: userEmail.text,
                                  ))
                              : null,
                          child: let(() {
                            if (isWorking) {
                              return const LoadingIndicator(
                                color: Colors.white,
                              );
                            }

                            return Text(LocaleKeys.Save.tr());
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
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
