import 'package:json_annotation/json_annotation.dart';

part 'geo_point_dto.g.dart';

@JsonSerializable()
class GeoPointDto {
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  const GeoPointDto({
    required this.latitude,
    required this.longitude,
  });

  factory GeoPointDto.fromJson(Map<String, dynamic> json) => _$GeoPointDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoPointDtoToJson(this);
}
