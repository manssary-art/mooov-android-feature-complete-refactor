part of 'order_placement_step_review.dart';

class _OrderPlacementStepReviewContentAddress extends StatelessWidget {
  final OrderAddressModel address;
  final String title;
  final AssetGenImage icon;

  const _OrderPlacementStepReviewContentAddress({
    super.key,
    required this.address,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final addressFormatted = address.displayAddress;
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
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(addressFormatted),
            if (address.hasElevator != null) ...[
              const SizedBox(height: 8),
              Text(address.hasElevator == true ? LocaleKeys.Elevator.tr() : LocaleKeys.Stairs.tr()),
            ],
            const SizedBox(height: 8),
            Text('${LocaleKeys.FloorsNumber.tr()}: ${address.floor ?? LocaleKeys.Blank.tr()}'),
            const SizedBox(height: 8),
            Text('${LocaleKeys.DoorCode.tr()}: ${address.doorEntryCode ?? LocaleKeys.Blank.tr()}'),
            const SizedBox(height: 8),
            Text(
              '${LocaleKeys.Contact.tr()}: ${address.contactPhone ?? LocaleKeys.Blank.tr()}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
