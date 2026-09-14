import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:network_api/apis/order_activities_api.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/order_mapper.dart';
import '../../models/order_model.dart';
import '../user/user_repository.dart';
import 'order_activities_repository.dart';

class OrderActivitiesRepositoryImpl implements OrderActivitiesRepository {
  final OrderActivitiesApi orderActivitiesApi;
  final UserRepository userRepository;

  OrderActivitiesRepositoryImpl({
    required this.orderActivitiesApi,
    required this.userRepository,
    required StreamController<OrderModel> onOrderChanged,
  }) {
    _onStart(onOrderChanged);
  }

  final _onRelatedOrdersChanged = StreamController<List<OrderModel>>.broadcast();

  void _onStart(
    StreamController<OrderModel> onOrderChanged,
  ) async {
    var nearbyOrders = <OrderModel>[];
    _onRelatedOrdersChanged.stream.listen((value) {
      if (listEquals(nearbyOrders, value)) return;
      nearbyOrders = value;
      value.forEach(onOrderChanged.add);
    });

    onOrderChanged.stream.listen((value) {
      final next = nearbyOrders.map((e) => e.orderId == value.orderId ? value : e).toList();
      if (listEquals(nearbyOrders, next)) return;
      nearbyOrders = next;
      _onRelatedOrdersChanged.add(next);
    });
  }

  @override
  Stream<List<OrderModel>> get onRelatedOrdersChanged => _onRelatedOrdersChanged.stream;

  @override
  Future<Result<List<OrderModel>>> getRelatedOrders() async => resultOf(() async {
        return userRepository
            .getUserId()
            .flatMapValue((e) => orderActivitiesApi.getOrdersForUser(userId: e).asHttpResponseResult())
            .mapValue((e) => e.mapNotNull((e) => e.toOrderModelOrNull()))
            .onValue((e) => _onRelatedOrdersChanged.add(e));
      });
}
