import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/apis/order_api.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/order_mapper.dart';
import '../../models/order_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi orderApi;
  final StreamController<OrderModel> _onOrderChanged;

  OrderRepositoryImpl({
    required this.orderApi,
    required StreamController<OrderModel> onOrderChanged,
  }) : _onOrderChanged = onOrderChanged;

  @override
  Stream<OrderModel> get onOrderChanged => _onOrderChanged.stream;

  @override
  Future<Result<OrderModel>> getOrderById({
    required String orderId,
  }) =>
      resultOf(() async {
        return await orderApi
            .getOrderById(orderId: orderId)
            .asHttpResponseResult()
            .mapValue((e) => e.toOrderModelOrNull())
            .flatMapValue((e) {
          if (e != null) {
            return Result<OrderModel>.value(e);
          } else {
            return Result<OrderModel>.error(Exception('Unable to parse order'));
          }
        }).onValue((e) => _onOrderChanged.add(e));
      });

  @override
  Future<Result<void>> deleteOrderById({
    required String orderId,
  }) =>
      resultOf(() async {
        return await orderApi.deleteOrderById(orderId: orderId).asHttpResponseResult();
      });
}
