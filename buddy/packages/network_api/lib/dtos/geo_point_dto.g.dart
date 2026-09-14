// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_point_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPointDto _$GeoPointDtoFromJson(Map<String, dynamic> json) => GeoPointDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoPointDtoToJson(GeoPointDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
