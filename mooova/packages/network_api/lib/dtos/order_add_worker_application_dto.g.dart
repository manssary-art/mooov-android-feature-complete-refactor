// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_add_worker_application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAddWorkerApplicationDto _$OrderAddWorkerApplicationDtoFromJson(
        Map<String, dynamic> json) =>
    OrderAddWorkerApplicationDto(
      workerId: json['moooverId'] as String,
      orderId: json['orderId'] as String,
      pickupTime:
          (json['pickupTime'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$OrderAddWorkerApplicationDtoToJson(
        OrderAddWorkerApplicationDto instance) =>
    <String, dynamic>{
      'moooverId': instance.workerId,
      'orderId': instance.orderId,
      'pickupTime': instance.pickupTime,
    };
