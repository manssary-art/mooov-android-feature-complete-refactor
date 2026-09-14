import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/order_price_recommendation_dto.dart';

part 'order_price_recommendation_api.g.dart';

@RestApi()
abstract class OrderPriceRecommendationApi {
  factory OrderPriceRecommendationApi(
    Dio dio, {
    String? baseUrl,
  }) = _OrderPriceRecommendationApi;

  @PUT("/v1/orders/price-recommendations")
  Future<HttpResponse<OrderPriceRecommendationsDto>> getPriceRecommendation({
    @Body() required OrderPriceRecommendationAddressDto body,
  });
}
