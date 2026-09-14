// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUpdateDto _$OrderUpdateDtoFromJson(Map<String, dynamic> json) =>
    OrderUpdateDto(
      orderId: json['id'] as String,
      description: json['description'] as String?,
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      adminFee: (json['adminFee'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      deliveryAddresses: (json['deliveryAddresses'] as List<dynamic>?)
          ?.map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pickupAddress: json['pickupAddress'] == null
          ? null
          : AddressDto.fromJson(json['pickupAddress'] as Map<String, dynamic>),
      numOfWorkersRequested: json['moooverRequested'] as int?,
      orderType: json['type'] as String?,
      orderSize: json['size'] as String?,
      itemCondition: json['condition'] as String?,
      currencyCode: json['currencyCode'] as String?,
      ownerId: json['ownerId'] as String?,
      pickupTime:
          (json['pickupTime'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$OrderUpdateDtoToJson(OrderUpdateDto instance) =>
    <String, dynamic>{
      'id': instance.orderId,
      'description': instance.description,
      'finalPrice': instance.finalPrice,
      'adminFee': instance.adminFee,
      'currencyCode': instance.currencyCode,
      'images': instance.images,
      'deliveryAddresses': instance.deliveryAddresses,
      'pickupAddress': instance.pickupAddress,
      'moooverRequested': instance.numOfWorkersRequested,
      'type': instance.orderType,
      'size': instance.orderSize,
      'condition': instance.itemCondition,
      'ownerId': instance.ownerId,
      'pickupTime': instance.pickupTime,
    };
