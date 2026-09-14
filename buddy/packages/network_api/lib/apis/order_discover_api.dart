import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/order_dto.dart';

part 'order_discover_api.g.dart';

@RestApi()
abstract class OrderDiscoverApi {
  factory OrderDiscoverApi(
    Dio dio, {
    String? baseUrl,
  }) = _OrderDiscoverApi;

  @GET("/v1/orders/lookup-all")
  Future<HttpResponse<List<OrderDto>>> getNearbyOrders({
    @Query("latitude") required double latitude,
    @Query("longitude") required double longitude,
  });
}
