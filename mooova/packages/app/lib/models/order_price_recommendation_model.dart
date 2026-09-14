import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'types/order_size_type.dart';

class OrderPriceRecommendationModel with EquatableMixin {
  final Currency currency;
  final Money adminFee;
  final Money priceLimit;
  final Money estimatedPrice;
  final Money additionalWorkerPrice;
  final int? time;
  final Money? taxiPrice;
  final Money? rentalPrice;
  final OrderSize orderSize;

  const OrderPriceRecommendationModel({
    required this.currency,
    required this.adminFee,
    required this.priceLimit,
    required this.estimatedPrice,
    required this.additionalWorkerPrice,
    required this.time,
    required this.taxiPrice,
    required this.rentalPrice,
    required this.orderSize,
  });

  @override
  List<Object?> get props => [
        currency,
        adminFee,
        priceLimit,
        estimatedPrice,
        additionalWorkerPrice,
        time,
        taxiPrice,
        rentalPrice,
        orderSize,
      ];

  OrderPriceRecommendationModel copyWith({
    Currency Function()? currency,
    Money Function()? adminFee,
    Money Function()? priceLimit,
    Money Function()? estimatedPrice,
    Money Function()? additionalWorkerPrice,
    int Function()? time,
    Money Function()? taxiPrice,
    Money Function()? rentalPrice,
    OrderSize Function()? size,
  }) {
    return OrderPriceRecommendationModel(
      currency: currency != null ? currency() : this.currency,
      adminFee: adminFee != null ? adminFee() : this.adminFee,
      priceLimit: priceLimit != null ? priceLimit() : this.priceLimit,
      estimatedPrice: estimatedPrice != null ? estimatedPrice() : this.estimatedPrice,
      additionalWorkerPrice: additionalWorkerPrice != null ? additionalWorkerPrice() : this.additionalWorkerPrice,
      time: time != null ? time() : this.time,
      taxiPrice: taxiPrice != null ? taxiPrice() : this.taxiPrice,
      rentalPrice: rentalPrice != null ? rentalPrice() : this.rentalPrice,
      orderSize: size != null ? size() : this.orderSize,
    );
  }
}
