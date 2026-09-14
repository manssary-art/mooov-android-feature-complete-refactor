import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'types/payment_method_type.dart';

class PaymentIntentModel with EquatableMixin {
  final String publishableKey;
  final String clientSecret;
  final String orderId;
  final Money totalAmount;
  final Money discountAmount;
  final Money vatAmount;
  final Currency currency;
  final PaymentMethodType type;
  final DateTime finalPickUpTime;
  final String workerId;

  const PaymentIntentModel({
    required this.publishableKey,
    required this.clientSecret,
    required this.orderId,
    required this.totalAmount,
    required this.discountAmount,
    required this.vatAmount,
    required this.currency,
    required this.type,
    required this.finalPickUpTime,
    required this.workerId,
  });

  @override
  List<Object?> get props => [
        publishableKey,
        clientSecret,
        totalAmount,
        discountAmount,
        vatAmount,
        currency,
        type,
        orderId,
        finalPickUpTime,
    workerId,
      ];

  PaymentIntentModel copyWith({
    String Function()? publishableKey,
    String Function()? clientSecret,
    String Function()? orderId,
    Money Function()? totalAmount,
    Money Function()? discountAmount,
    Money Function()? vatAmount,
    Currency Function()? currency,
    PaymentMethodType Function()? type,
    DateTime Function()? finalPickUpTime,
    String Function()? workerId,
  }) {
    return PaymentIntentModel(
      publishableKey: publishableKey != null ? publishableKey() : this.publishableKey,
      clientSecret: clientSecret != null ? clientSecret() : this.clientSecret,
      orderId: orderId != null ? orderId() : this.orderId,
      totalAmount: totalAmount != null ? totalAmount() : this.totalAmount,
      discountAmount: discountAmount != null ? discountAmount() : this.discountAmount,
      vatAmount: vatAmount != null ? vatAmount() : this.vatAmount,
      currency: currency != null ? currency() : this.currency,
      type: type != null ? type() : this.type,
      finalPickUpTime: finalPickUpTime != null ? finalPickUpTime() : this.finalPickUpTime,
      workerId: workerId != null ? workerId() : this.workerId,
    );
  }
}
