import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/riverpod_ext.dart';
import '../../hooks/flutter_hooks.dart';
import 'models/available_payment_methods.dart';
import 'models/order_payment_screen_params.dart';
import 'models/order_payment_step.dart';
import 'providers/_order_payment_providers.dart';
import 'widgets/content/order_payment_screen_content.dart';

class OrderPaymentScreen extends HookConsumerWidget {
  final OrderPaymentScreenParams params;
  final VoidCallback onNavBack;

  const OrderPaymentScreen({
    super.key,
    required this.params,
    required this.onNavBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        orderPaymentProvider.overrideWith(() => OrderPaymentNotifier(params)),
      ],
      child: _OrderPaymentScreen(
        onNavBack: onNavBack,
      ),
    );
  }
}

class _OrderPaymentScreen extends HookConsumerWidget {
  final VoidCallback onNavBack;

  const _OrderPaymentScreen({
    super.key,
    required this.onNavBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = ref.watch(orderPaymentProvider);
    final initialNotifier = ref.watch(orderPaymentProvider.notifier);
    final sideEffect = ref.watch(sideEffectProvider);

    useEffect(
      () => sideEffect.stream.listen((effect) async {
        switch (effect) {
          case OrderPaymentSideEffect$NavBack():
            onNavBack();
            break;
          case OrderPaymentSideEffect$NavToCardPayment():
            break;
        }
      }).cancel,
      [sideEffect],
    );

    if (initial.isLoading && !initial.hasValue) {
      return OrderPaymentScreenContentLoading(
        onNavBackClicked: initialNotifier.onNavBackClicked,
      );
    }

    if (initial.hasError) {
      return OrderPaymentScreenContentError(
        error: initial.error,
        onNavBackClicked: initialNotifier.onNavBackClicked,
        onTryAgainClicked: initialNotifier.onTryAgainClicked,
      );
    }

    final order = initial.requireValue.order;
    final methods = initial.requireValue.methods;
    final cardMethod = methods.firstWhere((e) => e is AvailablePaymentMethod$Card) as AvailablePaymentMethod$Card;
    final promoCode = ref.watch(promoCodeProvider);
    final promoCodeNotifier = ref.watch(promoCodeProvider.notifier);
    final step = ref.watch(stepProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTowardsTransition(
          type: FadeTowardsTransitionType.rightToLeft,
          animation: animation,
          child: child,
        );
      },
      child: switch (step) {
        OrderPaymentStep.selectedMethod => HookBuilder(
            key: ValueKey(step),
            builder: (context) {
              return OrderPaymentScreenContentLoaded(
                onNavBackClicked: initialNotifier.onNavBackClicked,
                promoCode: useUpdateState(promoCode),
                onPromoCodeChanged: promoCodeNotifier.onValueChanged,
                amount: useUpdateState(cardMethod.intent.totalAmount),
                currency: useUpdateState(order.currency),
                availableMethods: useUpdateState(methods),
                discount: useUpdateState(cardMethod.intent.discountAmount),
                isApplyingPromoCode: useUpdateState(initial.isReloading),
              );
            },
          ),
        OrderPaymentStep.cardInfo => HookBuilder(
            key: ValueKey(step),
            builder: (context) {
              return OrderPaymentScreenContentLoaded(
                onNavBackClicked: initialNotifier.onNavBackClicked,
                promoCode: useUpdateState(promoCode),
                onPromoCodeChanged: promoCodeNotifier.onValueChanged,
                amount: useUpdateState(cardMethod.intent.totalAmount),
                currency: useUpdateState(order.currency),
                availableMethods: useUpdateState(methods),
                discount: useUpdateState(cardMethod.intent.discountAmount),
                isApplyingPromoCode: useUpdateState(initial.isRefreshing),
              );
            },
          )
      },
    );
  }
}
