// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_review_tags_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReviewTagsDto _$OrderReviewTagsDtoFromJson(Map<String, dynamic> json) =>
    OrderReviewTagsDto(
      workerTags: Map<String, String>.from(json['moooverTags'] as Map),
      userTags: Map<String, String>.from(json['userTags'] as Map),
    );

Map<String, dynamic> _$OrderReviewTagsDtoToJson(OrderReviewTagsDto instance) =>
    <String, dynamic>{
      'moooverTags': instance.workerTags,
      'userTags': instance.userTags,
    };
