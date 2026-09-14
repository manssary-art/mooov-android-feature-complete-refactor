import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:network_api/apis/order_activities_api.dart';
import 'package:network_api/apis/order_api.dart';
import 'package:network_api/apis/order_management_api.dart';
import 'package:network_api/dtos/order_set_delivered_dto.dart';
import 'package:network_api/dtos/order_set_picked_up_dto.dart';
import 'package:network_api/dtos/order_update_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/date_time_mapper.dart';
import '../../models/mappers/order_mapper.dart';
import '../../models/order_model.dart';
import '../user/user_repository.dart';
import 'order_activities_repository.dart';
import 'order_repository.dart';

class OrderActivitiesRepositoryImpl implements OrderActivitiesRepository {
  final OrderActivitiesApi orderActivitiesApi;
  final UserRepository userRepository;
  final OrderApi orderApi;
  final OrderRepository orderRepository;
  final OrderManagementApi orderManagementApi;

  OrderActivitiesRepositoryImpl({
    required this.orderActivitiesApi,
    required this.userRepository,
    required this.orderApi,
    required this.orderRepository,
    required this.orderManagementApi,
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

  @override
  Future<Result<void>> increaseOrderPrice({required String orderId, required double newPrice}) => resultOf(() async {
        return orderRepository.getOrderById(orderId: orderId).flatMapValue((currentOrder) {
          final dto = OrderUpdateDto(
            orderId: orderId,
            description: null,
            finalPrice: newPrice,
            adminFee: null,
            images: null,
            deliveryAddresses: null,
            pickupAddress: null,
            numOfWorkersRequested: null,
            orderType: null,
            orderSize: null,
            itemCondition: null,
            currencyCode: null,
            ownerId: null,
            pickupTime: (currentOrder.pickupTime ?? []).toDtoTimeInts(),
          );
          return orderApi
              .updateOrder(orderId: orderId, body: dto)
              .asHttpResponseResult()
              .onValue((e) => orderRepository.getOrderById(orderId: orderId));
        });
      });

  @override
  Future<Result<void>> confirmDelivery({required String orderId}) => resultOf(() async {
        return orderManagementApi
            .setOrderCompleted(orderId: orderId)
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });

  @override
  Future<Result<void>> setOrderPickedUp({
    required String orderId,
    required List<String> pickupImages,
  }) =>
      resultOf(() async {
        return orderManagementApi
            .setOrderPickedUp(
              orderId: orderId,
              body: OrderSetPickedUpDto(orderId: orderId, pickupImages: pickupImages),
            )
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });

  @override
  Future<Result<void>> setOrderDelivered({
    required String orderId,
    required List<String> deliveredImages,
  }) =>
      resultOf(() async {
        return orderManagementApi
            .setOrderDelivered(
              orderId: orderId,
              body: OrderSetDeliveredDto(orderId: orderId, deliveredImages: deliveredImages),
            )
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });

  @override
  Future<Result<void>> cancelOrder({required String orderId}) => resultOf(() async {
        return orderManagementApi
            .setOrderRefunded(orderId: orderId)
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });
}
