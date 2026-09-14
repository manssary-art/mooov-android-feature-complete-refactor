import 'package:core/core.dart';
import 'package:design_system/extensions/currency_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../../models/order_price_recommendation_model.dart';
import '../../../../../models/types/order_size_type.dart';
import '../../widgets/order_placement_content_num_of_workers_requested_switch.dart';
import '../../widgets/order_placement_content_order_size_switch.dart';
import '../../widgets/order_placement_content_price_wheel.dart';

part 'order_placement_step_price_num_of_workers_requested.dart';

part 'order_placement_step_price_order_size.dart';

part 'order_placement_step_price_reference.dart';

class OrderPlacementStepPriceContent extends HookWidget {
  final Money finalPrice;
  final double additionalFees;
  final OrderSize orderSize;
  final int numOfWorkersRequested;
  final OrderPriceRecommendationModel recommendation;
  final void Function() onContinueClicked;
  final void Function(OrderSize value) onOrderSizeChanged;
  final void Function(int value) onNumOfWorkerRequestedChanged;
  final void Function(Money value) onFinalPriceChanged;

  const OrderPlacementStepPriceContent({
    super.key,
    required this.finalPrice,
    required this.additionalFees,
    required this.orderSize,
    required this.numOfWorkersRequested,
    required this.recommendation,
    required this.onContinueClicked,
    required this.onOrderSizeChanged,
    required this.onNumOfWorkerRequestedChanged,
    required this.onFinalPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    final feesAppliedForSize = useRef<OrderSize?>(null);

    useEffect(() {
      if (additionalFees > 0 && feesAppliedForSize.value != orderSize) {
        feesAppliedForSize.value = orderSize;
        Future(() {
          onFinalPriceChanged(finalPrice + additionalFees);
        });
      }
      return null;
    }, [orderSize]);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 8),
              _OrderPlacementStepPriceContentOrderSize(
                orderSize: orderSize,
                onOrderSizeChanged: onOrderSizeChanged,
              ),
              const SizedBox(height: 16),
              OrderPlacementContentPriceWheel(
                currency: recommendation.currency,
                onPriceChanged: onFinalPriceChanged,
                initial: finalPrice,
                min: 0.0,
                max: recommendation.priceLimit,
              ),
              if (additionalFees > 0) ...[
                const SizedBox(height: 8),
                Text(
                  LocaleKeys.IncludesAssemblyStairsFees.tr(namedArgs: {'#1': recommendation.currency.format(additionalFees)}),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFFFFB800),
                      width: 5,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.red,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        LocaleKeys.PricesExcludeFeesNote.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _OrderPlacementStepPriceContentNumOfWorkersRequested(
                numOfWorkersRequested: numOfWorkersRequested,
                onNumOfWorkerRequestedChanged: onNumOfWorkerRequestedChanged,
              ),
              const SizedBox(height: 16),
              _OrderPlacementStepPriceContentPriceReference(
                recommendation: recommendation,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FilledButton(
              onPressed: onContinueClicked,
              child: Text(LocaleKeys.Continue.tr()),
            ),
          ),
        ),
      ],
    );
  }
}
