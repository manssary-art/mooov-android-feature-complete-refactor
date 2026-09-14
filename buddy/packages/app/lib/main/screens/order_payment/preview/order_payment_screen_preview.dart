import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:preview/preview.dart';
import '../../../../preview/helpers/preview_fake_models.dart';
import '../../../core/riverpod_ext.dart';
import '../../../hooks/flutter_hooks.dart';
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
    final order = useMemoized(() => fakeOrderModel());
    final steps = OrderPaymentStep.values.associateBy((e) => e.name);
    final step = usePreviewOptions('Step', steps.keys.toList()).let((it) => steps[it]!);
    final isApplyingPromoCode = useUpdateState(usePreviewSwitch('isApplyingPromoCode', false));
    final amount = useUpdateState(usePreviewInputNumeric('amount'));
    final discount = useUpdateState(usePreviewInputNumeric('discount'));
    final promoCode = useState<String>('');
    final currency = useState<Currency>(Currency.SEK);
    final availableMethods = useState([
      AvailablePaymentMethod$SavedCard(fakePaymentIntentModel(), (id:'id', last4: '1234', brand: 'amex')),
      AvailablePaymentMethod$Card(fakePaymentIntentModel()),
      AvailablePaymentMethod$Klarna(fakePaymentIntentModel()),
    ]);

    return OrderPaymentScreenContentLoaded(
      onNavBackClicked: () {},
      promoCode: promoCode,
      currency: currency,
      amount: amount,
      availableMethods: availableMethods,
      onPromoCodeChanged: promoCode.onValueChanged,
      discount: discount,
      isApplyingPromoCode: isApplyingPromoCode,
    );
  }
}
