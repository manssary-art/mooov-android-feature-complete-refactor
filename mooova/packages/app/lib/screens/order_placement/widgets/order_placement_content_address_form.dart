import 'package:core/core.dart';
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
  final Country? country;
  final bool assembly;
  final ValueSetter<bool>? onAssemblyToggled;
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
    this.country,
    this.onAssemblyToggled,
    this.assembly = false,
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

        if (icon == Assets.images.iconMarkerPickUp) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: assembly,
                        activeColor: Colors.yellow,
                        onChanged: (val) => onAssemblyToggled?.call(val ?? false),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        LocaleKeys.DisassemblyAtPickup.tr(),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (assembly) ...[
            const SizedBox(height: 8),
            if (country == null)
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  LocaleKeys.PleaseSelectAddressFirst.tr(),
                  style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              )
            else
              Builder(builder: (context) {
                final currencyCode = country!.code;
                final assemblyFee = assemblyPrice.priceForCountry(currencyCode);
                if (assemblyFee == null) return const SizedBox.shrink();
                final symbol = currencySymbol.forCountry(currencyCode);
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.yellow.shade700, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.yellow.shade700, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          LocaleKeys.NeedHelpDisassemblingMessage.tr(namedArgs: {'#1': '$symbol$assemblyFee'}),
                          style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ],

        const SizedBox(height: 8),
        if (!hasElevator) ...[
          if (country == null)
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                LocaleKeys.PleaseSelectAddressFirst.tr(),
                style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.15),
                border: Border.all(color: Colors.orange, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    final currencyCode = country!.code;
                    final Money? pricePerFloor = floorPrice.floorPerLvelPrice(currencyCode);
                    if (pricePerFloor == null) return const SizedBox.shrink();
                    final floorNumber = int.tryParse(floors) ?? 1;
                    final Money totalCost = pricePerFloor * floorNumber;
                    final symbol = currencySymbol.forCountry(currencyCode);
                    return Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        LocaleKeys.StairsSurchargeMessage.tr(namedArgs: {
                          '#1': '$symbol$pricePerFloor',
                          '#2': '$floorNumber',
                          '#3': '$symbol${totalCost.toStringAsFixed(1)}',
                        }),
                        style: TextStyle(color: Colors.red[700], fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ],
              ),
            ),
        ],

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

abstract class floorPrice {
  static const _floorPriceMap = {
    'SE': 50.0,
    'NO': 50.0,
    'NL': 5.0,
    'DE': 5.0,
    'FI': 5.0,
    'ES': 5.0,
    'GR': 5.0,
    'PT': 5.0,
  };

  static Money? floorPerLvelPrice(String currencyCode) {
    return _floorPriceMap[currencyCode.toUpperCase()];
  }
}

abstract class currencySymbol {
  static const _symbolMap = {
    'SE': 'kr',
    'NO': 'kr',
    'NL': '€',
    'DE': '€',
    'FI': '€',
    'ES': '€',
    'GR': '€',
    'PT': '€',
  };

  static String forCountry(String countryCode) {
    return _symbolMap[countryCode.toUpperCase()] ?? '€';
  }
}

abstract class assemblyPrice {
  static const Map<String, double> disassemblyPrices = {
    'SE': 120.0,
    'NO': 120.0,
    'NL': 10.0,
    'DE': 10.0,
    'FI': 10.0,
    'ES': 7.0,
    'GR': 7.0,
    'PT': 7.0,
  };

  static double? priceForCountry(String currencyCode) {
    return disassemblyPrices[currencyCode.toUpperCase()];
  }
}
