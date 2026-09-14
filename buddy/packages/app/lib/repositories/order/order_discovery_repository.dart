import 'package:async/async.dart';
import 'package:core/core.dart';

import '../../models/order_model.dart';

abstract interface class OrderDiscoveryRepository {
  Stream<List<OrderModel>> get onNearbyOrdersChanged;

  Future<Result<List<OrderModel>>> getNearbyOrders({required bool requestPermission});
}
