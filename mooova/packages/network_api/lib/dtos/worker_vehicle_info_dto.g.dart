// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_vehicle_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerVehicleInfo _$WorkerVehicleInfoFromJson(Map<String, dynamic> json) =>
    WorkerVehicleInfo(
      imageUrl: json['image'] as String?,
      plate: json['plate'] as String?,
    );

Map<String, dynamic> _$WorkerVehicleInfoToJson(WorkerVehicleInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.imageUrl);
  writeNotNull('plate', instance.plate);
  return val;
}
