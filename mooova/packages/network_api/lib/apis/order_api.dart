import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/order_create_dto.dart';
import '../dtos/order_dto.dart';
import '../dtos/order_update_dto.dart';

part 'order_api.g.dart';

@RestApi()
abstract class OrderApi {
  factory OrderApi(
    Dio dio, {
    String? baseUrl,
  }) = _OrderApi;

  @GET("/v1/orders/lookup")
  Future<HttpResponse<OrderDto>> getOrderById({
    @Query('id') required String orderId,
  });

  @DELETE("/v1/orders/delete/{orderId}")
  Future<HttpResponse<void>> deleteOrderById({
    @Path('orderId') required String orderId,
  });

  @POST("/v1/orders/create")
  Future<HttpResponse<void>> createOrder({
    @Body() required OrderCreateDto body,
  });

  @PUT("/v1/orders/{orderId}")
  Future<HttpResponse<void>> updateOrder({
    @Path('orderId') required String orderId,
    @Body() required OrderUpdateDto body,
  });
}
