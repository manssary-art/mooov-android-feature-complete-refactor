// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_set_delivered_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSetDeliveredDto _$OrderSetDeliveredDtoFromJson(
        Map<String, dynamic> json) =>
    OrderSetDeliveredDto(
      orderId: json['id'] as String,
      deliveredImages: (json['deliveredImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OrderSetDeliveredDtoToJson(
        OrderSetDeliveredDto instance) =>
    <String, dynamic>{
      'id': instance.orderId,
      'deliveredImages': instance.deliveredImages,
    };
