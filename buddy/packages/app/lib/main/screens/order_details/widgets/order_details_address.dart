import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:linkable/linkable.dart';

import '../../../../models/order_address_model.dart';
import '../models/order_details_display_mode.dart';

class OrderDetailsAddress extends StatelessWidget {
  final OrderAddressModel address;
  final String title;
  final AssetGenImage icon;
  final OrderDetailsDisplayMode displayMode;
  final ValueSetter<String> onAddressClicked;
  final VoidCallback onNavigateClicked;

  const OrderDetailsAddress({
    super.key,
    required this.address,
    required this.displayMode,
    required this.title,
    required this.icon,
    required this.onAddressClicked,
    required this.onNavigateClicked,
  });

  @override
  Widget build(BuildContext context) {
    final obfuscate = let(() {
      if (displayMode is OrderDetailsDisplayMode$Owner) return false;
      if (displayMode is OrderDetailsDisplayMode$WorkerAssigned) return false;
      return true;
    });
    final addressFormatted = obfuscate ? address.displayAddressObfuscated : address.displayAddress;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            icon.image(
              width: 24,
              height: 24,
            ),
            Container(width: 8),
            Text(title),
            if (displayMode is OrderDetailsDisplayMode$WorkerAssigned) ...[
              Container(width: 8),
              InkWell(
                onTap: onNavigateClicked,
                child: Transform.rotate(
                  angle: 45,
                  child: const Icon(
                    Icons.navigation,
                    size: 22,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Clickable(
              onTap: () => onAddressClicked(addressFormatted),
              child: Text(addressFormatted),
            ),
            if (address.hasElevator != null) ...[
              const SizedBox(height: 8),
              Text(address.hasElevator == true ? LocaleKeys.Elevator.tr() : LocaleKeys.Stairs.tr()),
            ],
            const SizedBox(height: 8),
            Text('${LocaleKeys.FloorsNumber.tr()}: ${address.toFloorOrBlank(obfuscate)}'),
            const SizedBox(height: 8),
            Text('${LocaleKeys.DoorCode.tr()}: ${address.toPinCodeOrBlank(obfuscate)}'),
            if (!obfuscate) ...[
              const SizedBox(height: 8),
              Linkable(
                text: '${LocaleKeys.Contact.tr()}: ${address.toContactOrBlank(obfuscate)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

extension on OrderAddressModel {
  String toFloorOrBlank(bool obfuscate) {
    return obfuscate ? LocaleKeys.HiddenNow.tr() : floor ?? LocaleKeys.Blank.tr();
  }

  String toPinCodeOrBlank(bool obfuscate) {
    return obfuscate ? LocaleKeys.HiddenNow.tr() : doorEntryCode ?? LocaleKeys.Blank.tr();
  }

  String toContactOrBlank(bool obfuscate) {
    return obfuscate ? LocaleKeys.HiddenNow.tr() : contactPhone ?? LocaleKeys.Blank.tr();
  }
}
