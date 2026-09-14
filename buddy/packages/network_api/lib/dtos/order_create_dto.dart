import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';

part 'order_create_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderCreateDto {
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'finalPrice')
  final double? finalPrice;
  @JsonKey(name: 'adminFee')
  final double? adminFee;
  @JsonKey(name: 'currencyCode')
  final String? currencyCode;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'deliveryAddresses')
  final List<AddressDto>? deliveryAddresses;
  @JsonKey(name: 'pickupAddress')
  final AddressDto? pickupAddress;
  @JsonKey(name: 'moooverRequested')
  final int? numOfWorkersRequested;
  @JsonKey(name: 'type')
  final String? orderType;
  @JsonKey(name: 'size')
  final String? orderSize;
  @JsonKey(name: 'condition')
  final String? itemCondition;
  @JsonKey(name: 'ownerId')
  final String? ownerId;
  @JsonKey(name: 'pickupTime')
  final List<int> pickupTime;

  const OrderCreateDto({
    required this.description,
    required this.finalPrice,
    required this.adminFee,
    required this.images,
    required this.deliveryAddresses,
    required this.pickupAddress,
    required this.numOfWorkersRequested,
    required this.orderType,
    required this.orderSize,
    required this.itemCondition,
    required this.currencyCode,
    required this.ownerId,
    required this.pickupTime,
  });

  factory OrderCreateDto.fromJson(Map<String, dynamic> json) => _$OrderCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateDtoToJson(this);
}
