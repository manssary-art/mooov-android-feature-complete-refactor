import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/apis/order_management_api.dart';
import 'package:network_api/dtos/order_add_worker_application_dto.dart';
import 'package:network_api/dtos/order_delete_worker_application_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/date_time_mapper.dart';
import 'order_candidate_repository.dart';
import 'order_repository.dart';

class OrderCandidateRepositoryImpl implements OrderCandidateRepository {
  final OrderManagementApi orderManagementApi;
  final OrderRepository orderRepository;

  OrderCandidateRepositoryImpl({
    required this.orderManagementApi,
    required this.orderRepository,
  });

  @override
  Future<Result<void>> addWorkerApplicationForOrder({
    required String orderId,
    required String workerId,
    required List<DateTime> pickupTimes,
  }) =>
      resultOf(() async {
        return orderManagementApi
            .addWorkerApplicationForOrder(
                body: OrderAddWorkerApplicationDto(
              workerId: workerId,
              orderId: orderId,
              pickupTime: pickupTimes.toDtoTimeInts(),
            ))
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });

  @override
  Future<Result<void>> deleteWorkerApplicationForOrder({
    required String orderId,
    required String workerId,
  }) =>
      resultOf(() async {
        return orderManagementApi
            .deleteWorkerApplicationForOrder(
                orderId: orderId,
                workerId: workerId,
                body: OrderDeleteWorkerApplicationDto(
                  workerId: workerId,
                  orderId: orderId,
                ))
            .asHttpResponseResult()
            .onValue((e) => orderRepository.getOrderById(orderId: orderId));
      });
}
