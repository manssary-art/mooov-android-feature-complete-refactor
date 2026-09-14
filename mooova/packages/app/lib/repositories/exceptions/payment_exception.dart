import 'package:flutter_stripe/flutter_stripe.dart';

import '../../health/health_monitor_exception_mixin.dart';
import '../../models/types/payment_method_type.dart' as internal;

class PaymentIntentResultException with HealthMonitorExceptionMixin implements Exception {
  final PaymentIntentsStatus status;
  final String? description;
  final internal.PaymentMethodType type;
  final String orderId;

  const PaymentIntentResultException({
    required this.status,
    required this.description,
    required this.type,
    required this.orderId,
  });

  @override
  String toString() => "PaymentException(${status.toValue()}, $description)";

  @override
  Map<String, String?> get keys => {
        'status': status.toValue(),
        'type': type.toDtoType(),
        'orderId': orderId,
      };
}

class PaymentFailedToSetWorkerException with HealthMonitorExceptionMixin implements Exception {
  final String? description;
  final String orderId;
  final String workerId;

  const PaymentFailedToSetWorkerException({
    required this.workerId,
    required this.description,
    required this.orderId,
  });

  @override
  String toString() => "PaymentFailedToSetWorkerException(${orderId}, $description)";

  @override
  Map<String, String?> get keys => {
        'workerId': workerId,
        'orderId': orderId,
      };
}

extension on PaymentIntentsStatus {
  String toValue() => switch (this) {
        PaymentIntentsStatus.Succeeded => 'Succeeded',
        PaymentIntentsStatus.RequiresPaymentMethod => 'RequiresPaymentMethod',
        PaymentIntentsStatus.RequiresConfirmation => 'RequiresConfirmation',
        PaymentIntentsStatus.Canceled => 'Canceled',
        PaymentIntentsStatus.Processing => 'Processing',
        PaymentIntentsStatus.RequiresAction => 'RequiresAction',
        PaymentIntentsStatus.RequiresCapture => 'RequiresCapture',
        PaymentIntentsStatus.Unknown => 'Unknown',
      };
}
