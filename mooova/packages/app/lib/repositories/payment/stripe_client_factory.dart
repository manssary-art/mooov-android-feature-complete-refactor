import 'dart:async';

import 'package:flutter_stripe/flutter_stripe.dart';

class StripeClientFactory {
  static Completer<Stripe>? _stripeCompleter;

  Future<Stripe> create({
    required String publishableKey,
  }) async {
    if (_stripeCompleter != null) {
      return await _stripeCompleter!.future;
    }

    try {
      _stripeCompleter = Completer<Stripe>();
      Stripe.publishableKey = publishableKey;
      Stripe.urlScheme = 'mooovastripe';
      await Stripe.instance.applySettings();
      _stripeCompleter!.complete(Stripe.instance);
      return Stripe.instance;
    } catch (e) {
      _stripeCompleter = null;
      rethrow;
    }
  }
}

extension StripeClientExt on Stripe {
  Future<bool> isPaymentApproved(String clientSecret) async {
    try {
      final intent = await retrievePaymentIntent(clientSecret);
      return intent.status == PaymentIntentsStatus.Succeeded || intent.status == PaymentIntentsStatus.RequiresCapture;
    } catch (e) {
      return false;
    }
  }
}
