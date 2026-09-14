part of 'order_placement_step_review.dart';

class _OrderPlacementStepReviewContentOffer extends StatelessWidget {
  final Currency currency;
  final Money finalPrice;
  final Money adminFee;

  const _OrderPlacementStepReviewContentOffer({
    super.key,
    required this.finalPrice,
    required this.adminFee,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final offer = LocaleKeys.OfferPrice.tr(namedArgs: {'#1': currency.format(finalPrice) ?? '', '#2': ""});

    final Money serviceFee = adminFee + (finalPrice * 0.10);
    final serviceFeeText = LocaleKeys.ServiceFee.tr(namedArgs: {'#1': currency.format(serviceFee) ?? '', '#2': ""});

    final Money totalGross = finalPrice + serviceFee;
    final totalGrossText = LocaleKeys.TotalFee.tr(
      namedArgs: {'#1': currency.format(totalGross), '#2': ""},
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: ColorName.neutral5,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              offer,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                Text(
                  serviceFeeText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.info,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
              ],
            ),
          ),
          Text(
            totalGrossText,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
