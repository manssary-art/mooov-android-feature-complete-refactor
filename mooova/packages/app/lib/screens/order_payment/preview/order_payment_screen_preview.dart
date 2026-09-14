import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:preview/preview.dart';

import '../../../../core/ext/riverpod_ext.dart';
import '../../../../core/hooks/flutter_hooks.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../models/available_payment_methods.dart';
import '../models/order_payment_step.dart';
import '../widgets/content/order_payment_screen_content.dart';

class OrderPaymentScreenPreview extends HookWidget with PreviewMixin {
  OrderPaymentScreenPreview({
    super.key,
  });

  @override
  String get name => 'OrderPaymentScreen';

  @override
  Widget build(BuildContext context) {
    final steps = OrderPaymentStep.values.associateBy((e) => e.name);
    final step = usePreviewOptions('Step', steps.keys.toList()).let((it) => steps[it]!);
    final isApplyingPromoCode = useUpdateState(usePreviewSwitch('isApplyingPromoCode', false));
    final amount = useUpdateState(usePreviewInputNumeric('amount'));
    final discount = useUpdateState(usePreviewInputNumeric('discount'));
    final promoCode = useState<String>('');
    final currency = useState<Currency>(Currency.SEK);
    final isSaveCardEnabled = useState<bool>(false);
    final availableMethods = useState([
      AvailablePaymentMethod$SavedCard(fakePaymentIntentModel(), (id: 'id', last4: '1234', brand: 'amex')),
      AvailablePaymentMethod$Card(fakePaymentIntentModel()),
      AvailablePaymentMethod$Klarna(fakePaymentIntentModel()),
    ]);

    final cardNumber = useState<String?>(null);
    final cvc = useState<String?>(null);
    final expMonth = useState<String?>(null);
    final expYear = useState<String?>(null);
    return switch (step) {
      OrderPaymentStep.selectMethod => OrderPaymentScreenContentLoadedSelectMethod(
          onNavBackClicked: () {},
          promoCode: promoCode,
          currency: currency,
          amount: amount,
          availableMethods: availableMethods,
          onPromoCodeChanged: promoCode.onValueChanged,
          discount: discount,
          isApplyingPromoCode: isApplyingPromoCode,
        ),
      OrderPaymentStep.cardInfo => OrderPaymentScreenContentLoadedCardInfo(
          cardNumber: cardNumber,
          cvc: cvc,
          expMonth: expMonth,
          expYear: expYear,
          isSaveCardEnabled: isSaveCardEnabled,
          onNavBackClicked: () {},
          onSubmitClicked: () {},
          onSaveCardChanged: isSaveCardEnabled.onValueChanged,
          onCardNumberChanged: cardNumber.onValueChanged,
          onCvcNumberChanged: cvc.onValueChanged,
          onExpMonthChanged: expMonth.onValueChanged,
          onExpYearChanged: expYear.onValueChanged,
        ),
    };
  }
}
