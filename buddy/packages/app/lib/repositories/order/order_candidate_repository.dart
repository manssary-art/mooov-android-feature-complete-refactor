import 'package:async/async.dart';

abstract interface class OrderCandidateRepository {
  Future<Result<void>> addWorkerApplicationForOrder({
    required String orderId,
    required String workerId,
    required List<DateTime> pickupTimes,
  });

  Future<Result<void>> deleteWorkerApplicationForOrder({
    required String orderId,
    required String workerId,
  });
}
