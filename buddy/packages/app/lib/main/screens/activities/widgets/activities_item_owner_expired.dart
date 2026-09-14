import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/locale_keys.gen.dart';

import '../models/activities_order_item.dart';

class ActivitiesItemOwnerExpired extends StatelessWidget {
  final ActivitiesOrderItem$Owner$Expired item;
  final VoidCallback onOwnerEmailSupportClicked;
  final VoidCallback onOwnerRenewOrderClicked;

  const ActivitiesItemOwnerExpired({
    super.key,
    required this.item,
    required this.onOwnerEmailSupportClicked,
    required this.onOwnerRenewOrderClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onOwnerEmailSupportClicked,
            child: Text(LocaleKeys.Support.tr()),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FilledButton(
            onPressed: onOwnerRenewOrderClicked,
            child: Text(LocaleKeys.RenewOrderButton.tr()),
          ),
        ),
      ],
    );
  }
}
