import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/auth_step.dart';

class AuthenticationHeaderContent extends HookWidget {
  final AuthStep authStep;

  const AuthenticationHeaderContent({
    super.key,
    required this.authStep,
  });

  @override
  Widget build(BuildContext context) {
    if (authStep == AuthStep.enterInfo) {
      return Text(
        LocaleKeys.AddName.tr(),
        style: Theme.of(context).textTheme.headlineLarge,
      );
    } else {
      return Assets.images.imageAuthBanner.image();
    }
  }
}
