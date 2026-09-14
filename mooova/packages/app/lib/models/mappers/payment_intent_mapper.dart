import 'package:core/core.dart';
import 'package:network_api/dtos/payment_intent_dto.dart';

import '../payment_intent_model.dart';
import '../types/payment_method_type.dart';

extension PaymentIntentDtoMapperExt on PaymentIntentDto {
  PaymentIntentModel toPaymentIntentModel({
    required String orderId,
    required PaymentMethodType type,
    required DateTime finalPickUpTime,
    required String workerId,
  }) =>
      PaymentIntentModel(
        publishableKey: publishableKey,
        clientSecret: clientSecret,
        totalAmount: totalAmount.toDouble(),
        discountAmount: discountAmount.toDouble(),
        vatAmount: vatAmount.toDouble(),
        currency: currencyCode.toCurrencyOrNull()!,
        type: type,
        orderId: orderId,
        finalPickUpTime: finalPickUpTime,
        workerId: workerId,
      );
}
