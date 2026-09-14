// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_delete_worker_application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDeleteWorkerApplicationDto _$OrderDeleteWorkerApplicationDtoFromJson(
        Map<String, dynamic> json) =>
    OrderDeleteWorkerApplicationDto(
      workerId: json['moooverId'] as String,
      orderId: json['orderId'] as String,
    );

Map<String, dynamic> _$OrderDeleteWorkerApplicationDtoToJson(
        OrderDeleteWorkerApplicationDto instance) =>
    <String, dynamic>{
      'moooverId': instance.workerId,
      'orderId': instance.orderId,
    };
