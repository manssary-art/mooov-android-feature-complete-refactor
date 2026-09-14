import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class ActivitiesDialogWorkerRefund extends StatelessWidget {
  final VoidCallback onConfirm;

  const ActivitiesDialogWorkerRefund({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        LocaleKeys.CancelIntroMooover.tr(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorName.error),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(LocaleKeys.RefundButtonMooover.tr(), style: TextStyle(color: ColorName.error)),
        ),
      ],
    );
  }
}
