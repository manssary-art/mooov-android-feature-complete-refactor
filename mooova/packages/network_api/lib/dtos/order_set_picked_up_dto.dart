import 'package:json_annotation/json_annotation.dart';

part 'order_set_picked_up_dto.g.dart';

@JsonSerializable()
class OrderSetPickedUpDto {
  @JsonKey(name: 'id')
  final String orderId;
  @JsonKey(name: 'pickupImages')
  final List<String> pickupImages;

  const OrderSetPickedUpDto({
    required this.orderId,
    required this.pickupImages,
  });

  factory OrderSetPickedUpDto.fromJson(Map<String, dynamic> json) => _$OrderSetPickedUpDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSetPickedUpDtoToJson(this);
}
