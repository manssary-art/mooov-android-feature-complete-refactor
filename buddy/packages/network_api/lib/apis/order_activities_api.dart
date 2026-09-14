import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/order_dto.dart';

part 'order_activities_api.g.dart';

@RestApi()
abstract class OrderActivitiesApi {
  factory OrderActivitiesApi(
    Dio dio, {
    String? baseUrl,
  }) = _OrderActivitiesApi;

  @GET("/v1/orders/lookup-related")
  Future<HttpResponse<List<OrderDto>>> getOrdersForUser({
    @Query("userid") required String userId,
  });
}
