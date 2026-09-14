import 'package:async/async.dart';

import '../../models/order_model.dart';

abstract interface class OrderActivitiesRepository {
  Stream<List<OrderModel>> get onRelatedOrdersChanged;

  Future<Result<List<OrderModel>>> getRelatedOrders();

  Future<Result<void>> increaseOrderPrice({required String orderId, required double newPrice});

  Future<Result<void>> confirmDelivery({required String orderId});
}
