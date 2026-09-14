import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'order_worker_candidate_dto.dart';
import 'user_dto.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: 'id')
  final String orderId;
  @JsonKey(name: 'owner')
  final UserDto? owner;
  @JsonKey(name: 'mooover')
  final UserDto? worker;
  @JsonKey(name: 'candidates')
  final List<OrderWorkerCandidate>? candidates;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'currencyCode')
  final String? currencyCode;
  @JsonKey(name: 'originalPrice')
  final double? originalPrice;
  @JsonKey(name: 'finalPrice')
  final double? finalPrice;
  @JsonKey(name: 'adminFee')
  final double? adminFee;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'pickupImages')
  final List<String>? pickupImages;
  @JsonKey(name: 'deliveredImages')
  final List<String>? deliveredImages;
  @JsonKey(name: 'deliveryAddresses')
  final List<AddressDto>? deliveryAddresses;
  @JsonKey(name: 'pickupAddress')
  final AddressDto? pickupAddress;
  @JsonKey(name: 'deliverTime')
  final int? deliverTime;
  @JsonKey(name: 'finalPickupTime')
  final int? finalPickupTime;
  @JsonKey(name: 'pickupTime')
  final List<int>? pickupTime;
  @JsonKey(name: 'moooverRequested')
  final int? numOfWorkersRequested;
  @JsonKey(name: 'state')
  final String orderState;
  @JsonKey(name: 'type')
  final String orderType;
  @JsonKey(name: 'totalDistance')
  final int? totalDistance;
  @JsonKey(name: 'estimatedPrice')
  final double? estimatedPrice;
  @JsonKey(name: 'size')
  final String orderSize;
  @JsonKey(name: 'condition')
  final String? itemCondition;

  const OrderDto({
    required this.orderId,
    required this.owner,
    required this.worker,
    required this.candidates,
    required this.description,
    required this.currencyCode,
    required this.originalPrice,
    required this.finalPrice,
    required this.adminFee,
    required this.images,
    required this.pickupImages,
    required this.deliveredImages,
    required this.deliveryAddresses,
    required this.pickupAddress,
    required this.deliverTime,
    required this.finalPickupTime,
    required this.pickupTime,
    required this.numOfWorkersRequested,
    required this.orderState,
    required this.orderType,
    required this.totalDistance,
    required this.estimatedPrice,
    required this.orderSize,
    required this.itemCondition,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}
