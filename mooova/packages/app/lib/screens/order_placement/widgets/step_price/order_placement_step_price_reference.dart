part of 'order_placement_step_price.dart';

class _OrderPlacementStepPriceContentPriceReference extends HookWidget {
  final OrderPriceRecommendationModel recommendation;

  const _OrderPlacementStepPriceContentPriceReference({
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    final time = recommendation.time;
    final taxiPrice = recommendation.taxiPrice;
    final rentalPrice = recommendation.rentalPrice;

    if (time == null && taxiPrice == null && rentalPrice == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.PriceViewReference.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.neutral80),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(builder: (context) {
              final style = Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorName.neutral80);
              textFactory(first, second, third) => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: style,
                      children: <TextSpan>[
                        TextSpan(text: "$first ", style: style?.copyWith(fontSize: 20)),
                        TextSpan(text: "$second"),
                        TextSpan(text: "\n$third"),
                      ],
                    ),
                  );

              return Row(
                children: [
                  if (time != null) ...[
                    Expanded(
                      child: textFactory(
                        time,
                        'Min',
                        LocaleKeys.PriceReference1.tr(),
                      ),
                    ),
                  ],
                  if (taxiPrice != null) ...[
                    Expanded(
                      child: textFactory(
                        taxiPrice!.toInt(),
                        recommendation.currency.symbol(),
                        LocaleKeys.PriceReference2.tr(),
                      ),
                    ),
                  ],
                  if (rentalPrice != null) ...[
                    Expanded(
                      child: textFactory(
                        rentalPrice!.toInt(),
                        recommendation.currency.symbol(),
                        LocaleKeys.PriceReference3.tr(),
                      ),
                    ),
                  ],
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
