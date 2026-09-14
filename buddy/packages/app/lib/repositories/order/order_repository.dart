import 'package:async/async.dart';
import 'package:core/core.dart';

import '../../models/order_model.dart';

abstract interface class OrderRepository {
  Stream<OrderModel> get onOrderChanged;

  Future<Result<OrderModel>> getOrderById({required String orderId});

  Future<Result<void>> deleteOrderById({required String orderId});
}
