import 'package:async/async.dart';

abstract interface class DeepLinksRepository {
  Future<Result<String>> getDeepLinkForOrderId({required String orderId});
}
