import 'package:core/core.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

class OrderDetailsPriceOffer extends StatelessWidget {
  final Currency currency;
  final Money finalPrice;
  final Money? estimatedPrice;

  const OrderDetailsPriceOffer({
    super.key,
    required this.currency,
    required this.finalPrice,
    required this.estimatedPrice,
  });

  @override
  Widget build(BuildContext context) {
    final finalPrice = this.finalPrice;
    final percentage = estimatedPrice?.toPercentage(finalPrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${LocaleKeys.Offer.tr()}:',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: Container()),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    LocaleKeys.TotalFee.tr(namedArgs: {
                      '#1': currency.format(finalPrice),
                      '#2': "",
                    }),
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (percentage != null && percentage > 0) ...[
          Container(height: 8),
          Text(
            LocaleKeys.ComparedToPricing.tr(namedArgs: {
              '#1': percentage.abs().toString(),
            }),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
          ),
        ],
      ],
    );
  }
}

extension on Money {
  int toPercentage(Money total) {
    return 100 - ((total * 100) / this).ceil();
  }
}
