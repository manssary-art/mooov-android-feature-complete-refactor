// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateDto _$OrderCreateDtoFromJson(Map<String, dynamic> json) =>
    OrderCreateDto(
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

Map<String, dynamic> _$OrderCreateDtoToJson(OrderCreateDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('finalPrice', instance.finalPrice);
  writeNotNull('adminFee', instance.adminFee);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('images', instance.images);
  writeNotNull('deliveryAddresses', instance.deliveryAddresses);
  writeNotNull('pickupAddress', instance.pickupAddress);
  writeNotNull('moooverRequested', instance.numOfWorkersRequested);
  writeNotNull('type', instance.orderType);
  writeNotNull('size', instance.orderSize);
  writeNotNull('condition', instance.itemCondition);
  writeNotNull('ownerId', instance.ownerId);
  val['pickupTime'] = instance.pickupTime;
  return val;
}
