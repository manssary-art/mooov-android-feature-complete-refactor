// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_set_picked_up_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSetPickedUpDto _$OrderSetPickedUpDtoFromJson(Map<String, dynamic> json) =>
    OrderSetPickedUpDto(
      orderId: json['id'] as String,
      pickupImages: (json['pickupImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OrderSetPickedUpDtoToJson(
        OrderSetPickedUpDto instance) =>
    <String, dynamic>{
      'id': instance.orderId,
      'pickupImages': instance.pickupImages,
    };
