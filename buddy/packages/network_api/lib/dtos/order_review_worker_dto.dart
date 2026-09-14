import 'package:json_annotation/json_annotation.dart';

part 'order_review_worker_dto.g.dart';

@JsonSerializable()
class OrderReviewWorkerDto {
  @JsonKey(name: 'orderId')
  final String orderId;
  @JsonKey(name: 'moooverId')
  final String workerId;
  @JsonKey(name: 'rate')
  final double score;
  @JsonKey(name: 'tags')
  final List<String> tags;
  @JsonKey(name: 'comment')
  final String comment;

  const OrderReviewWorkerDto({
    required this.orderId,
    required this.workerId,
    required this.score,
    required this.tags,
    required this.comment,
  });

  factory OrderReviewWorkerDto.fromJson(Map<String, dynamic> json) => _$OrderReviewWorkerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderReviewWorkerDtoToJson(this);
}
