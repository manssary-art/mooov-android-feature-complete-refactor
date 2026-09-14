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
    final fee = LocaleKeys.AdminFee.tr(namedArgs: {'#1': currency.format(adminFee) ?? '', '#2': ""});
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
                  fee,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(LocaleKeys.AdminFeeDes.tr()),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.info,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
          Text(
            LocaleKeys.TotalFee.tr(
              namedArgs: {'#1': currency.format(finalPrice + adminFee), '#2': ""},
            ),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
