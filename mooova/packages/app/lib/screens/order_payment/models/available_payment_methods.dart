import '../../../../models/payment_intent_model.dart';
import '../../../../repositories/payment/saved_payment_method_repository.dart';

sealed class AvailablePaymentMethod {}

class AvailablePaymentMethod$Card implements AvailablePaymentMethod {
  final PaymentIntentModel intent;
  const AvailablePaymentMethod$Card(this.intent);
}

class AvailablePaymentMethod$Klarna implements AvailablePaymentMethod {
  final PaymentIntentModel intent;
  const AvailablePaymentMethod$Klarna(this.intent);
}

class AvailablePaymentMethod$SavedCard implements AvailablePaymentMethod {
  final PaymentIntentModel intent;
  final SavedCardInfoModel info;

  const AvailablePaymentMethod$SavedCard(this.intent, this.info);
}
