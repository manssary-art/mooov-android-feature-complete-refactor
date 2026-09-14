part of 'order_placement_step_price.dart';

class _OrderPlacementStepPriceContentOrderSize extends HookWidget {
  final OrderSize orderSize;
  final void Function(OrderSize value) onOrderSizeChanged;

  const _OrderPlacementStepPriceContentOrderSize({
    required this.orderSize,
    required this.onOrderSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.PriceViewTitle.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        OrderPlacementContentOrderSizeSwitch(
          selected: orderSize,
          onItemClicked: onOrderSizeChanged,
        ),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.PriceViewDes.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
