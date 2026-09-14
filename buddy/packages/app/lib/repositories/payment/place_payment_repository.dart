import 'package:async/async.dart';
import 'package:core/core.dart';

import '../../models/payment_intent_model.dart';
import '../../models/types/payment_method_type.dart';

abstract class PlacePaymentRepository {
  Future<Result<PaymentIntentModel>> createIntent({
    required String orderId,
    required String workerId,
    required String? promoCode,
    required DateTime finalPickUpTime,
    required PaymentMethodType type,
  });

  Future<Result<void>> placeCardPayment({
    required PaymentIntentModel intent,
    required String number,
    required int expirationYear,
    required int expirationMonth,
    required String cvc,
    required bool save,
  });

  Future<Result<void>> placeKlarnaPayment({
    required PaymentIntentModel intent,
  });

  Future<Result<void>> placeSavedCardPayment({
    required PaymentIntentModel intent,
    required String id,
  });
}

