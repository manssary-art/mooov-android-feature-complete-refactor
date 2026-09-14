import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/apis/order_rating_api.dart';
import 'package:network_api/dtos/order_review_worker_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import 'order_rating_repository.dart';
import 'order_repository.dart';

class OrderRatingRepositoryImpl implements OrderRatingRepository {
  final OrderRatingApi orderRatingApi;
  final OrderRepository orderRepository;

  OrderRatingRepositoryImpl({
    required this.orderRatingApi,
    required this.orderRepository,
  });

  @override
  Future<Result<Map<String, String>>> fetchRatingTags() => resultOf(() async {
        return orderRatingApi
            .getOrderReviewTags()
            .asHttpResponseResult()
            .mapValue((dto) => dto.workerTags);
      });

  @override
  Future<Result<void>> rateOrder({
    required String orderId,
    required String workerId,
    required double rate,
    required List<String> tags,
    required String comment,
  }) =>
      resultOf(() async {
        final body = OrderReviewWorkerDto(
          orderId: orderId,
          workerId: workerId,
          score: rate,
          tags: tags,
          comment: comment,
        );

        return orderRatingApi
            .setOrderWorkerReview(
              orderId: orderId,
              workerId: workerId,
              score: rate.toString(),
              body: body,
            )
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });
}
