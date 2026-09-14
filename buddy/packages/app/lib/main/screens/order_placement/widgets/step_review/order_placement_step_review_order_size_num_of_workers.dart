part of 'order_placement_step_review.dart';

class _OrderPlacementStepReviewContentOrderSizeNumOfWorkersRequested
    extends StatelessWidget {
  final OrderSize orderSize;
  final int numOfWorkerRequested;

  const _OrderPlacementStepReviewContentOrderSizeNumOfWorkersRequested({
    super.key,
    required this.orderSize,
    required this.numOfWorkerRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: orderSize.let((size) {
            switch (size) {
              case OrderSize.s:
                return Assets.images.imageOrderSizeSmall;
              case OrderSize.m:
                return Assets.images.imageOrderSizeMedium;
              case OrderSize.l:
                return Assets.images.imageOrderSizeLarge;
            }
          }).image(fit: BoxFit.cover),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.NeedHowManyPeople.tr(
                    namedArgs: {'#1': numOfWorkerRequested.toString()}),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                  shape: BoxShape.rectangle,
                ),
                child: SizedBox(
                  width: 80,
                  height: 32,
                  child: let(() {
                    if (numOfWorkerRequested == 1) {
                      return Assets.images.iconMoverOneGray
                          .image(color: ColorName.neutral80);
                    } else {
                      return Assets.images.iconMoverTwoGray
                          .image(color: ColorName.neutral80);
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
