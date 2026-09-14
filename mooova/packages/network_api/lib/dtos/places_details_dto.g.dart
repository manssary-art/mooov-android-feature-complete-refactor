// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesDetailsResponseDto _$PlacesDetailsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    PlacesDetailsResponseDto(
      status: json['status'] as String?,
      place: json['result'] == null
          ? null
          : PlacesDetailsDto.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlacesDetailsResponseDtoToJson(
        PlacesDetailsResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.place,
    };

PlacesDetailsDto _$PlacesDetailsDtoFromJson(Map<String, dynamic> json) =>
    PlacesDetailsDto(
      addressComponents: (json['address_components'] as List<dynamic>?)
          ?.map((e) => PlacesDetailsDto$AddressComponent.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      adrAddress: json['adr_address'] as String?,
      formattedAddress: json['formatted_address'] as String?,
      formattedPhoneNumber: json['formatted_phone_number'] as String?,
      icon: json['icon'] as String?,
      id: json['id'] as String?,
      internationalPhoneNumber: json['international_phone_number'] as String?,
      name: json['name'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      scope: json['scope'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      url: json['url'] as String?,
      utcOffset: json['utc_offset'] as int?,
      vicinity: json['vicinity'] as String?,
      website: json['website'] as String?,
      geometry: json['geometry'] == null
          ? null
          : PlacesDetailsDto$Geometry.fromJson(
              json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlacesDetailsDtoToJson(PlacesDetailsDto instance) =>
    <String, dynamic>{
      'address_components': instance.addressComponents,
      'adr_address': instance.adrAddress,
      'formatted_address': instance.formattedAddress,
      'formatted_phone_number': instance.formattedPhoneNumber,
      'icon': instance.icon,
      'id': instance.id,
      'international_phone_number': instance.internationalPhoneNumber,
      'name': instance.name,
      'place_id': instance.placeId,
      'reference': instance.reference,
      'scope': instance.scope,
      'types': instance.types,
      'url': instance.url,
      'utc_offset': instance.utcOffset,
      'vicinity': instance.vicinity,
      'website': instance.website,
      'geometry': instance.geometry,
    };

PlacesDetailsDto$AddressComponent _$PlacesDetailsDto$AddressComponentFromJson(
        Map<String, dynamic> json) =>
    PlacesDetailsDto$AddressComponent(
      longName: json['long_name'] as String?,
      shortName: json['short_name'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlacesDetailsDto$AddressComponentToJson(
        PlacesDetailsDto$AddressComponent instance) =>
    <String, dynamic>{
      'long_name': instance.longName,
      'short_name': instance.shortName,
      'types': instance.types,
    };

PlacesDetailsDto$Geometry _$PlacesDetailsDto$GeometryFromJson(
        Map<String, dynamic> json) =>
    PlacesDetailsDto$Geometry(
      location: json['location'] == null
          ? null
          : PlacesDetailsDto$Location.fromJson(
              json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlacesDetailsDto$GeometryToJson(
        PlacesDetailsDto$Geometry instance) =>
    <String, dynamic>{
      'location': instance.location,
    };

PlacesDetailsDto$Location _$PlacesDetailsDto$LocationFromJson(
        Map<String, dynamic> json) =>
    PlacesDetailsDto$Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlacesDetailsDto$LocationToJson(
        PlacesDetailsDto$Location instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
