import 'package:json_annotation/json_annotation.dart';

part 'order_review_tags_dto.g.dart';

@JsonSerializable()
class OrderReviewTagsDto {
  @JsonKey(name: 'moooverTags')
  final Map<String, String> workerTags;
  @JsonKey(name: 'userTags')
  final Map<String, String> userTags;

  const OrderReviewTagsDto({
    required this.workerTags,
    required this.userTags,
  });

  factory OrderReviewTagsDto.fromJson(Map<String, dynamic> json) => _$OrderReviewTagsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderReviewTagsDtoToJson(this);
}
