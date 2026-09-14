import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import 'order_placement_content_field_input.dart';
import 'order_placement_content_has_elevator_switch.dart';

class OrderPlacementContentAddressForm extends HookWidget {
  final AssetGenImage icon;
  final String title;
  final String? streetAddress;
  final bool hasElevator;
  final String floors;
  final String doorCode;
  final String contactPhone;
  final ValueSetter<bool> onHasElevatorToggled;
  final ValueSetter<String> onFloorContentChanged;
  final ValueSetter<String> onDoorCodeContentChanged;
  final ValueSetter<String> onContactPhoneContentChanged;
  final VoidCallback onStreetAddressClicked;

  const OrderPlacementContentAddressForm({
    super.key,
    required this.icon,
    required this.title,
    required this.streetAddress,
    required this.hasElevator,
    required this.floors,
    required this.doorCode,
    required this.contactPhone,
    required this.onFloorContentChanged,
    required this.onDoorCodeContentChanged,
    required this.onContactPhoneContentChanged,
    required this.onHasElevatorToggled,
    required this.onStreetAddressClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SimpleAssetImageTextTile(
          image: icon,
          text: title,
          textStyle: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Clickable(
          onTap: onStreetAddressClicked,
          child: OrderPlacementContentFieldInput(
            content: streetAddress ?? '',
            hint: LocaleKeys.SearchAddress.tr(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.FitInElevator.tr(),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                LocaleKeys.FloorsNumber.tr(),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            OrderPlacementContentHasElevatorSwitch(
              selected: hasElevator,
              onItemClicked: onHasElevatorToggled,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                width: 80,
                child: OrderPlacementContentFieldInput(
                  hint: "1",
                  content: floors,
                  onContentChanged: onFloorContentChanged,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.DoorCodeOptional.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    LocaleKeys.HideWhenCompleted.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.ContactOptional.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    LocaleKeys.HideWhenCompleted.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              flex: 3,
              child: OrderPlacementContentFieldInput(
                hint: "123",
                content: doorCode,
                onContentChanged: onDoorCodeContentChanged,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
            Flexible(
              flex: 7,
              child: OrderPlacementContentFieldInput(
                hint: "000000000",
                content: contactPhone,
                onContentChanged: onContactPhoneContentChanged,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
