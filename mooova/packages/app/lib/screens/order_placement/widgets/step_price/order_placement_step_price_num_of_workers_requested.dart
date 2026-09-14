part of 'order_placement_step_price.dart';

class _OrderPlacementStepPriceContentNumOfWorkersRequested extends HookWidget {
  final int numOfWorkersRequested;
  final void Function(int value) onNumOfWorkerRequestedChanged;

  const _OrderPlacementStepPriceContentNumOfWorkersRequested({
    required this.numOfWorkersRequested,
    required this.onNumOfWorkerRequestedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.OneOrTwo.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        OrderPlacementContentNumOfWorkersRequestedSwitch(
          selected: numOfWorkersRequested,
          onItemClicked: onNumOfWorkerRequestedChanged,
        ),
      ],
    );
  }
}
