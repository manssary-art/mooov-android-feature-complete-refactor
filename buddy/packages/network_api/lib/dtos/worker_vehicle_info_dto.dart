import 'package:json_annotation/json_annotation.dart';

part 'worker_vehicle_info_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class WorkerVehicleInfo {
  @JsonKey(name: 'image')
  final String? imageUrl;
  @JsonKey(name: 'plate')
  final String? plate;

  const WorkerVehicleInfo({
    required this.imageUrl,
    required this.plate,
  });

  factory WorkerVehicleInfo.fromJson(Map<String, dynamic> json) => _$WorkerVehicleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerVehicleInfoToJson(this);
}
