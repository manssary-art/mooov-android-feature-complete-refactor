import 'package:json_annotation/json_annotation.dart';

part 'order_delete_worker_application_dto.g.dart';

@JsonSerializable()
class OrderDeleteWorkerApplicationDto {
  @JsonKey(name: 'moooverId')
  final String workerId;
  @JsonKey(name: 'orderId')
  final String orderId;

  const OrderDeleteWorkerApplicationDto({required this.workerId, required this.orderId});

  factory OrderDeleteWorkerApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDeleteWorkerApplicationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDeleteWorkerApplicationDtoToJson(this);
}
