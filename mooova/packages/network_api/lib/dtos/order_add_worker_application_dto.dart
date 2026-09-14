import 'package:json_annotation/json_annotation.dart';

part 'order_add_worker_application_dto.g.dart';

@JsonSerializable()
class OrderAddWorkerApplicationDto {
  @JsonKey(name: 'moooverId')
  final String workerId;
  @JsonKey(name: 'orderId')
  final String orderId;
  @JsonKey(name: 'pickupTime')
  final List<int> pickupTime;

  const OrderAddWorkerApplicationDto({
    required this.workerId,
    required this.orderId,
    required this.pickupTime,
  });

  factory OrderAddWorkerApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$OrderAddWorkerApplicationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAddWorkerApplicationDtoToJson(this);
}
