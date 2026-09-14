// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_auto_complete_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesAutoCompleteResponseDto _$PlacesAutoCompleteResponseDtoFromJson(
        Map<String, dynamic> json) =>
    PlacesAutoCompleteResponseDto(
      status: json['status'] as String?,
      places: (json['predictions'] as List<dynamic>?)
          ?.map(
              (e) => PlacesAutoCompleteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlacesAutoCompleteResponseDtoToJson(
        PlacesAutoCompleteResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'predictions': instance.places,
    };

PlacesAutoCompleteDto _$PlacesAutoCompleteDtoFromJson(
        Map<String, dynamic> json) =>
    PlacesAutoCompleteDto(
      description: json['description'] as String?,
      distanceMeters: json['distance_meters'] as int?,
      id: json['id'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] == null
          ? null
          : PlacesAutoCompleteDto$Structured.fromJson(
              json['structured_formatting'] as Map<String, dynamic>),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlacesAutoCompleteDtoToJson(
        PlacesAutoCompleteDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'distance_meters': instance.distanceMeters,
      'id': instance.id,
      'place_id': instance.placeId,
      'reference': instance.reference,
      'structured_formatting': instance.structuredFormatting,
      'types': instance.types,
    };

PlacesAutoCompleteDto$Structured _$PlacesAutoCompleteDto$StructuredFromJson(
        Map<String, dynamic> json) =>
    PlacesAutoCompleteDto$Structured(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );

Map<String, dynamic> _$PlacesAutoCompleteDto$StructuredToJson(
        PlacesAutoCompleteDto$Structured instance) =>
    <String, dynamic>{
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
    };
