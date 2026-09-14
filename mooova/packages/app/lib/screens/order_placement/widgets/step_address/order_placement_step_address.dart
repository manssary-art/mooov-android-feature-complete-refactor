import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../../../../models/order_address_model.dart';
import '../../../../../core/hooks/flutter_hooks.dart';
import '../../models/order_placement_address.dart';
import '../../widgets/order_placement_content_address_form.dart';
import '../../widgets/order_placement_content_time_picker.dart';

part 'order_placement_step_address_add_more.dart';

class OrderPlacementStepAddressContent extends HookWidget {
  final List<OrderAddressModel> addresses;
  final bool isSubmitEnabled;
  final void Function(int key, bool value) onHasElevatorToggled;
  final void Function(int key, bool value) onAssemblyToggled;
  final void Function(int key, String value) onFloorContentChanged;
  final void Function(int key, String value) onDoorCodeContentChanged;
  final void Function(int key, String value) onContactPhoneContentChanged;
  final void Function(List<DateTime> value) onPickUpTimesChanged;
  final void Function(int key) onStreetAddressClicked;
  final void Function() onAddDeliveryAddressClicked;
  final void Function() onContinueClicked;

  const OrderPlacementStepAddressContent({
    super.key,
    required this.addresses,
    required this.isSubmitEnabled,
    required this.onHasElevatorToggled,
    required this.onAssemblyToggled,
    required this.onFloorContentChanged,
    required this.onDoorCodeContentChanged,
    required this.onContactPhoneContentChanged,
    required this.onStreetAddressClicked,
    required this.onAddDeliveryAddressClicked,
    required this.onContinueClicked,
    required this.onPickUpTimesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final showSnackBar = useShowSnackBar(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final entry in addresses.asMap().entries) ...[
                OrderPlacementContentAddressForm(
                  title: let(() {
                    if (entry.key == pickUpAddressKey) return LocaleKeys.PickupAddress.tr();
                    return LocaleKeys.DeliveryAddress.tr();
                  }),
                  icon: let(() {
                    if (entry.key == pickUpAddressKey) return Assets.images.iconMarkerPickUp;
                    return Assets.images.iconMarkerDropOff;
                  }),
                  streetAddress: entry.value.streetAddress,
                  hasElevator: entry.value.hasElevator ?? false,
                  floors: entry.value.floor ?? '',
                  contactPhone: entry.value.contactPhone ?? '',
                  doorCode: entry.value.doorEntryCode ?? '',
                  country: entry.value.country,
                  assembly: entry.value.assembly ?? false,
                  onAssemblyToggled: (value) => onAssemblyToggled(entry.key, value),
                  onStreetAddressClicked: () => onStreetAddressClicked(entry.key),
                  onHasElevatorToggled: (value) => onHasElevatorToggled(entry.key, value),
                  onFloorContentChanged: (value) => onFloorContentChanged(entry.key, value),
                  onContactPhoneContentChanged: (value) => onContactPhoneContentChanged(entry.key, value),
                  onDoorCodeContentChanged: (value) => onDoorCodeContentChanged(entry.key, value),
                ),
                const Divider(height: 40),
              ],
              Clickable(
                onTap: onAddDeliveryAddressClicked,
                child: _OrderPlacementStepAddressAddMore(),
              ),
              const Divider(height: 40),
              SimpleAssetImageTextTile(
                image: Assets.images.iconClockRed,
                text: LocaleKeys.PickupDate.tr(),
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OrderPlacementContentTimePicker(
                    onSelectedTimesChanged: onPickUpTimesChanged,
                    onSelectedTimesLimitClicked: () => showSnackBar(LocaleKeys.Max5Slots.tr()),
                  ),
                ),
              ),
              const Divider(height: 40),
              FilledButton(
                onPressed: onContinueClicked.takeIf((_) => isSubmitEnabled),
                child: Text(LocaleKeys.Continue.tr()),
              )
            ],
          ),
        ),
      ],
    );
  }
}
