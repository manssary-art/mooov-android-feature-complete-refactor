// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_price_recommendation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPriceRecommendationAddressDto _$OrderPriceRecommendationAddressDtoFromJson(
        Map<String, dynamic> json) =>
    OrderPriceRecommendationAddressDto(
      pickupAddress:
          AddressDto.fromJson(json['pickupAddress'] as Map<String, dynamic>),
      deliveryAddresses: (json['deliveryAddresses'] as List<dynamic>)
          .map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderPriceRecommendationAddressDtoToJson(
        OrderPriceRecommendationAddressDto instance) =>
    <String, dynamic>{
      'pickupAddress': instance.pickupAddress,
      'deliveryAddresses': instance.deliveryAddresses,
    };

OrderPriceRecommendationsDto _$OrderPriceRecommendationsDtoFromJson(
        Map<String, dynamic> json) =>
    OrderPriceRecommendationsDto(
      recommendations: (json['priceRecommendations'] as List<dynamic>)
          .map((e) =>
              OrderPriceRecommendationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderPriceRecommendationsDtoToJson(
        OrderPriceRecommendationsDto instance) =>
    <String, dynamic>{
      'priceRecommendations': instance.recommendations,
    };

OrderPriceRecommendationDto _$OrderPriceRecommendationDtoFromJson(
        Map<String, dynamic> json) =>
    OrderPriceRecommendationDto(
      currency: json['currency'] as String,
      adminFee: (json['adminFee'] as num).toDouble(),
      priceLimit: (json['priceLimit'] as num).toDouble(),
      estimatedPrice: (json['estimatedPrice'] as num).toDouble(),
      totalDistance: (json['totalDistance'] as num).toDouble(),
      additionalWorkerPrice: (json['additionalMoooverPrice'] as num).toDouble(),
      time: json['time'] as int?,
      taxiPrice: (json['taxiPrice'] as num?)?.toDouble(),
      rentalPrice: (json['rentalPrice'] as num?)?.toDouble(),
      size: json['size'] as String,
    );

Map<String, dynamic> _$OrderPriceRecommendationDtoToJson(
        OrderPriceRecommendationDto instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'adminFee': instance.adminFee,
      'priceLimit': instance.priceLimit,
      'estimatedPrice': instance.estimatedPrice,
      'totalDistance': instance.totalDistance,
      'additionalMoooverPrice': instance.additionalWorkerPrice,
      'time': instance.time,
      'taxiPrice': instance.taxiPrice,
      'rentalPrice': instance.rentalPrice,
      'size': instance.size,
    };
