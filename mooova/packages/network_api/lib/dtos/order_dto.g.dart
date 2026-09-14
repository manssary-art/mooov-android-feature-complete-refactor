// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
      orderId: json['id'] as String,
      owner: json['owner'] == null
          ? null
          : UserDto.fromJson(json['owner'] as Map<String, dynamic>),
      worker: json['mooover'] == null
          ? null
          : UserDto.fromJson(json['mooover'] as Map<String, dynamic>),
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => OrderWorkerCandidate.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      currencyCode: json['currencyCode'] as String?,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      adminFee: (json['adminFee'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pickupImages: (json['pickupImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveredImages: (json['deliveredImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveryAddresses: (json['deliveryAddresses'] as List<dynamic>?)
          ?.map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pickupAddress: json['pickupAddress'] == null
          ? null
          : AddressDto.fromJson(json['pickupAddress'] as Map<String, dynamic>),
      deliverTime: json['deliverTime'] as int?,
      finalPickupTime: json['finalPickupTime'] as int?,
      pickupTime:
          (json['pickupTime'] as List<dynamic>?)?.map((e) => e as int).toList(),
      numOfWorkersRequested: json['moooverRequested'] as int?,
      orderState: json['state'] as String,
      orderType: json['type'] as String,
      totalDistance: json['totalDistance'] as int?,
      estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
      orderSize: json['size'] as String,
      itemCondition: json['condition'] as String?,
    );

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
      'id': instance.orderId,
      'owner': instance.owner,
      'mooover': instance.worker,
      'candidates': instance.candidates,
      'description': instance.description,
      'currencyCode': instance.currencyCode,
      'originalPrice': instance.originalPrice,
      'finalPrice': instance.finalPrice,
      'adminFee': instance.adminFee,
      'images': instance.images,
      'pickupImages': instance.pickupImages,
      'deliveredImages': instance.deliveredImages,
      'deliveryAddresses': instance.deliveryAddresses,
      'pickupAddress': instance.pickupAddress,
      'deliverTime': instance.deliverTime,
      'finalPickupTime': instance.finalPickupTime,
      'pickupTime': instance.pickupTime,
      'moooverRequested': instance.numOfWorkersRequested,
      'state': instance.orderState,
      'type': instance.orderType,
      'totalDistance': instance.totalDistance,
      'estimatedPrice': instance.estimatedPrice,
      'size': instance.orderSize,
      'condition': instance.itemCondition,
    };
