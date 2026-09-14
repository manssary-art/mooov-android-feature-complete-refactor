part of 'order_placement_step_address.dart';

class _OrderPlacementStepAddressAddMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: const Icon(Icons.add),
        ),
        Container(width: 8),
        Text(
          LocaleKeys.AddMore.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
