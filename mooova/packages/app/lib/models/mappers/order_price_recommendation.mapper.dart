import 'package:core/core.dart';
import 'package:network_api/dtos/order_price_recommendation_dto.dart';

import '../order_price_recommendation_model.dart';
import '../types/order_size_type.dart';

extension OrderPriceRecommendationDtoMapperExt on OrderPriceRecommendationDto {
  OrderPriceRecommendationModel toOrderPriceRecommendationModel() {
    return OrderPriceRecommendationModel(
      currency: currency.toCurrencyOrNull()!,
      adminFee: adminFee,
      priceLimit: priceLimit,
      estimatedPrice: estimatedPrice,
      additionalWorkerPrice: additionalWorkerPrice,
      time: time,
      taxiPrice: taxiPrice,
      rentalPrice: rentalPrice,
      orderSize: size.toOrderSizeOrNull()!,
    );
  }
}
