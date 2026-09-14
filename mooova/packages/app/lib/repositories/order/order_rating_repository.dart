import 'package:async/async.dart';

abstract interface class OrderRatingRepository {
  Future<Result<Map<String, String>>> fetchRatingTags();

  Future<Result<void>> rateOrder({
    required String orderId,
    required String workerId,
    required double rate,
    required List<String> tags,
    required String comment,
  });
}
