part of 'order_placement_step_review.dart';

class _OrderPlacementStepReviewContentProductCondition extends StatelessWidget {
  final ProductCondition productCondition;

  const _OrderPlacementStepReviewContentProductCondition({
    super.key,
    required this.productCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.HowCondition.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.0),
            shape: BoxShape.rectangle,
          ),
          child: Text(
            productCondition.let((value) {
              switch (value) {
                case ProductCondition.acceptable:
                  return LocaleKeys.Fair.tr();
                case ProductCondition.good:
                  return LocaleKeys.Good.tr();
                case ProductCondition.veryGood:
                  return LocaleKeys.VeryGood.tr();
              }
            }),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
