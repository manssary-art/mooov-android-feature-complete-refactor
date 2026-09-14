import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/order_add_worker_application_dto.dart';
import '../dtos/order_delete_worker_application_dto.dart';
import '../dtos/order_set_delivered_dto.dart';
import '../dtos/order_set_picked_up_dto.dart';

part 'order_management_api.g.dart';

@RestApi()
abstract class OrderManagementApi {
  factory OrderManagementApi(
    Dio dio, {
    String? baseUrl,
  }) = _OrderManagementApi;

  @POST("/v1/orders/apply")
  Future<HttpResponse<void>> addWorkerApplicationForOrder({
    @Body() required OrderAddWorkerApplicationDto body,
  });

  @DELETE("/v1/orders/{orderId}/candidates/{workerId}")
  Future<HttpResponse<void>> deleteWorkerApplicationForOrder({
    @Path('orderId') required String orderId,
    @Path('workerId') required String workerId,
    @Body() required OrderDeleteWorkerApplicationDto body,
  });

  @PUT("/v1/orders/update-set-mooover/{orderId}")
  Future<HttpResponse<void>> setOrderWorker({
    @Path('orderId') required String orderId,
    @Query('moooverId') required String workerId,
    @Query('finalPickupTime') required int pickUpTime,
  });

  @PUT("/v1/orders/update-price/{orderId}")
  Future<HttpResponse<void>> setOrderPrice({
    @Path('orderId') required String orderId,
    @Query('price') required int price,
  });

  @PUT("/v1/orders/update-pickupImages/{orderId}")
  Future<HttpResponse<void>> setOrderPickedUp({
    @Path('orderId') required String orderId,
    @Body() required OrderSetPickedUpDto body,
  });

  @PUT("/v1/orders/update-delivered/{orderId}")
  Future<HttpResponse<void>> setOrderDelivered({
    @Path('orderId') required String orderId,
    @Body() required OrderSetDeliveredDto body,
  });

  @PUT("/v1/orders/update-complete/{orderId}")
  Future<HttpResponse<void>> setOrderCompleted({
    @Path('orderId') required String orderId,
  });

  @POST("/v1/orders/{orderId}/cancellation")
  Future<HttpResponse<void>> setOrderRefunded({
    @Path('orderId') required String orderId,
  });
}
