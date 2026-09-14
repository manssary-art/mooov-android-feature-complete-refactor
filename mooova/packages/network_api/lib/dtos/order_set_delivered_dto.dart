import 'package:json_annotation/json_annotation.dart';

part 'order_set_delivered_dto.g.dart';

@JsonSerializable()
class OrderSetDeliveredDto {
  @JsonKey(name: 'id')
  final String orderId;
  @JsonKey(name: 'deliveredImages')
  final List<String> deliveredImages;

  const OrderSetDeliveredDto({
    required this.orderId,
    required this.deliveredImages,
  });

  factory OrderSetDeliveredDto.fromJson(Map<String, dynamic> json) => _$OrderSetDeliveredDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSetDeliveredDtoToJson(this);
}
