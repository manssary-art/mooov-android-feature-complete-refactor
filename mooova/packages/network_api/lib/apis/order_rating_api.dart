import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/order_review_tags_dto.dart';
import '../dtos/order_review_worker_dto.dart';

part 'order_rating_api.g.dart';

@RestApi()
abstract class OrderRatingApi {
  factory OrderRatingApi(
    Dio dio, {
    String? baseUrl,
  }) = _OrderRatingApi;

  @GET("/v1/orders/rate/rate-tags")
  Future<HttpResponse<OrderReviewTagsDto>> getOrderReviewTags();

  @PUT("/v1/orders/rate/{orderId}")
  Future<HttpResponse<void>> setOrderWorkerReview({
    @Path('orderId') required String orderId,
    @Query('moooverId') required String workerId,
    @Query('rate') required String score,
    @Body() required OrderReviewWorkerDto body,
  });
}
