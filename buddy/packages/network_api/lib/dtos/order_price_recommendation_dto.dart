import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';

part 'order_price_recommendation_dto.g.dart';

@JsonSerializable()
class OrderPriceRecommendationAddressDto {
  @JsonKey(name: 'pickupAddress')
  final AddressDto pickupAddress;

  @JsonKey(name: 'deliveryAddresses')
  final List<AddressDto> deliveryAddresses;

  const OrderPriceRecommendationAddressDto({
    required this.pickupAddress,
    required this.deliveryAddresses,
  });

  factory OrderPriceRecommendationAddressDto.fromJson(Map<String, dynamic> json) =>
      _$OrderPriceRecommendationAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPriceRecommendationAddressDtoToJson(this);
}

@JsonSerializable()
class OrderPriceRecommendationsDto {
  @JsonKey(name: 'priceRecommendations')
  final List<OrderPriceRecommendationDto> recommendations;

  const OrderPriceRecommendationsDto({
    required this.recommendations,
  });

  factory OrderPriceRecommendationsDto.fromJson(Map<String, dynamic> json) =>
      _$OrderPriceRecommendationsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPriceRecommendationsDtoToJson(this);
}

@JsonSerializable()
class OrderPriceRecommendationDto {
  @JsonKey(name: 'currency')
  final String currency;
  @JsonKey(name: 'adminFee')
  final double adminFee;
  @JsonKey(name: 'priceLimit')
  final double priceLimit;
  @JsonKey(name: 'estimatedPrice')
  final double estimatedPrice;
  @JsonKey(name: 'totalDistance')
  final double totalDistance;
  @JsonKey(name: 'additionalMoooverPrice')
  final double additionalWorkerPrice;
  @JsonKey(name: 'time')
  final int? time;
  @JsonKey(name: 'taxiPrice')
  final double? taxiPrice;
  @JsonKey(name: 'rentalPrice')
  final double? rentalPrice;
  @JsonKey(name: 'size')
  final String size;

  const OrderPriceRecommendationDto({
    required this.currency,
    required this.adminFee,
    required this.priceLimit,
    required this.estimatedPrice,
    required this.totalDistance,
    required this.additionalWorkerPrice,
    required this.time,
    required this.taxiPrice,
    required this.rentalPrice,
    required this.size,
  });

  factory OrderPriceRecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$OrderPriceRecommendationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPriceRecommendationDtoToJson(this);
}
