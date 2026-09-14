import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

import '../models/activities_order_item.dart';

class ActivitiesItemOwnerSelectCandidate extends StatelessWidget {
  final ActivitiesOrderItem$Owner$SelectCandidate item;
  final VoidCallback onOwnerSelectCandidateClicked;

  const ActivitiesItemOwnerSelectCandidate({
    super.key,
    required this.item,
    required this.onOwnerSelectCandidateClicked,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onOwnerSelectCandidateClicked,
      child: Text(LocaleKeys.SelectAMooover.tr()),
    );
  }
}
