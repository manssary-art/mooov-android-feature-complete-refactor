import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:network_api/apis/order_discover_api.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/geo_point_model.dart';
import '../../models/mappers/order_mapper.dart';
import '../../models/order_model.dart';
import '../../services/location/location_service.dart';
import 'order_discovery_repository.dart';

const _defaultGeoPoint = GeoPointModel(latitude: 59.332441, longitude: 18.064076);

class OrderDiscoveryRepositoryImpl implements OrderDiscoveryRepository {
  final OrderDiscoverApi orderDiscoverApi;
  final LocationService locationService;

  OrderDiscoveryRepositoryImpl({
    required this.orderDiscoverApi,
    required this.locationService,
    required StreamController<OrderModel> onOrderChanged,
  }) {
    _onStart(onOrderChanged);
  }

  final _onNearbyOrders = StreamController<List<OrderModel>>.broadcast();

  void _onStart(
    StreamController<OrderModel> onOrderChanged,
  ) async {
    var nearbyOrders = <OrderModel>[];
    _onNearbyOrders.stream.listen((value) {
      if (listEquals(nearbyOrders, value)) return;
      nearbyOrders = value;
      value.forEach(onOrderChanged.add);
    });

    onOrderChanged.stream.listen((value) {
      final next = nearbyOrders.map((e) => e.orderId == value.orderId ? value : e).toList();
      if (listEquals(nearbyOrders, next)) return;
      nearbyOrders = next;
      _onNearbyOrders.add(next);
    });
  }

  @override
  Stream<List<OrderModel>> get onNearbyOrdersChanged => _onNearbyOrders.stream;

  @override
  Future<Result<List<OrderModel>>> getNearbyOrders({
    required bool requestPermission,
  }) async =>
      resultOf(() async {
        var geoPoint = await locationService.requestLocation(requestPermission: requestPermission);
        geoPoint ??= _defaultGeoPoint;
        geoPoint = _defaultGeoPoint;
        return await orderDiscoverApi
            .getNearbyOrders(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            .asHttpResponseResult()
            .mapValue((e) => e.mapNotNull((e) => e.toOrderModelOrNull()))
            .onValue((e) => _onNearbyOrders.add(e));
      });
}
