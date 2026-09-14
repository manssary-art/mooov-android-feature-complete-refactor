// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_review_worker_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReviewWorkerDto _$OrderReviewWorkerDtoFromJson(
        Map<String, dynamic> json) =>
    OrderReviewWorkerDto(
      orderId: json['orderId'] as String,
      workerId: json['moooverId'] as String,
      score: (json['rate'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$OrderReviewWorkerDtoToJson(
        OrderReviewWorkerDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'moooverId': instance.workerId,
      'rate': instance.score,
      'tags': instance.tags,
      'comment': instance.comment,
    };
