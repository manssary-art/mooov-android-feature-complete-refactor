import 'package:json_annotation/json_annotation.dart';

part 'places_details_dto.g.dart';

@JsonSerializable()
class PlacesDetailsResponseDto {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'result')
  final PlacesDetailsDto? place;

  const PlacesDetailsResponseDto({
    this.status,
    this.place,
  });

  factory PlacesDetailsResponseDto.fromJson(Map<String, dynamic> json) => _$PlacesDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesDetailsResponseDtoToJson(this);
}

@JsonSerializable()
class PlacesDetailsDto {
  /// [addressComponents] is an array containing the separate components applicable to this address.
  @JsonKey(name: 'address_components')
  final List<PlacesDetailsDto$AddressComponent>? addressComponents;

  /// [adrAddress] is a representation of the place's address in the adr microformat.
  @JsonKey(name: 'adr_address')
  final String? adrAddress;

  /// [formattedAddress] is a string containing the human-readable address of this place.
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  /// [formattedPhoneNumber] contains the place's phone number in its local format. For example,
  /// the formatted_phone_number for Google's Sydney, Australia office is (02) 9374 4000.
  @JsonKey(name: 'formatted_phone_number')
  final String? formattedPhoneNumber;

  /// [icon] contains the URL of a suggested icon which may be displayed to the user when indicating this result on a map.
  @JsonKey(name: 'icon')
  final String? icon;

  /// [id] contains id.
  @JsonKey(name: 'id')
  final String? id;

  /// [internationalPhoneNumber] contains the place's phone number in international format.
  /// International format includes the country code, and is prefixed with the plus (+) sign.
  /// For example, the international_phone_number for Google's Sydney, Australia office is +61 2 9374 4000.
  @JsonKey(name: 'international_phone_number')
  final String? internationalPhoneNumber;

  /// [name] contains the human-readable name for the returned result. For establishment results,
  /// this is usually the canonicalized business name.
  @JsonKey(name: 'name')
  final String? name;

  /// [placeId] A textual identifier that uniquely identifies a place. To retrieve information about the place,
  /// pass this identifier in the placeId field of a Places API request. For more information about place IDs.
  @JsonKey(name: 'place_id')
  final String? placeId;

  /// [reference] contains reference.
  @JsonKey(name: 'reference')
  final String? reference;

  /// [scope] contains scope.
  @JsonKey(name: 'scope')
  final String? scope;

  /// [types] contains an array of feature types describing the given result.
  /// XML responses include multiple <type> elements if more than one type is assigned to the result.
  @JsonKey(name: 'types')
  final List<String>? types;

  /// [url] contains the URL of the official Google page for this place. This will be the Google-owned page
  /// that contains the best available information about the place. Applications must link to or embed
  /// this page on any screen that shows detailed results about the place to the user.
  @JsonKey(name: 'url')
  final String? url;

  /// [utcOffset] contains the number of minutes this place’s current timezone is offset from UTC.
  /// For example, for places in Sydney, Australia during daylight saving time this would be 660
  /// (+11 hours from UTC), and for places in California outside of daylight saving time this would be -480 (-8 hours from UTC).
  @JsonKey(name: 'utc_offset')
  final int? utcOffset;

  /// [vicinity] lists a simplified address for the place, including the street name, street number, and locality,
  /// but not the province/state, postal code, or country. For example, Google's Sydney, Australia office has a
  /// vicinity value of 48 Pirrama Road, Pyrmont.
  @JsonKey(name: 'vicinity')
  final String? vicinity;

  /// [website] lists the authoritative website for this place, such as a business' homepage.
  @JsonKey(name: 'website')
  final String? website;

  /// [geometry] contains Geometry object.
  final PlacesDetailsDto$Geometry? geometry;

  PlacesDetailsDto({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.icon,
    this.id,
    this.internationalPhoneNumber,
    this.name,
    this.placeId,
    this.reference,
    this.scope,
    this.types,
    this.url,
    this.utcOffset,
    this.vicinity,
    this.website,
    this.geometry,
  });

  factory PlacesDetailsDto.fromJson(Map<String, dynamic> json) => _$PlacesDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesDetailsDtoToJson(this);
}

@JsonSerializable()
class PlacesDetailsDto$AddressComponent {
  /// [longName] is the full text description or name of the address component as returned by the Geocoder.
  @JsonKey(name: 'long_name')
  final String? longName;

  /// [shortName] is an abbreviated textual name for the address component, if available.
  /// For example, an address component for the state of Alaska may have a long_name of "Alaska"
  /// and a short_name of "AK" using the 2-letter postal abbreviation.
  @JsonKey(name: 'short_name')
  final String? shortName;

  /// [types] is an array indicating the type of the address component.
  @JsonKey(name: 'types')
  final List<String>? types;

  PlacesDetailsDto$AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  factory PlacesDetailsDto$AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$PlacesDetailsDto$AddressComponentFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesDetailsDto$AddressComponentToJson(this);
}

@JsonSerializable()
class PlacesDetailsDto$Geometry {
  /// [location] contains the geocoded latitude,longitude value for this place.
  final PlacesDetailsDto$Location? location;

  PlacesDetailsDto$Geometry({
    this.location,
  });

  factory PlacesDetailsDto$Geometry.fromJson(Map<String, dynamic> json) => _$PlacesDetailsDto$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesDetailsDto$GeometryToJson(this);
}

@JsonSerializable()
class PlacesDetailsDto$Location {
  final double? lat;
  final double? lng;

  PlacesDetailsDto$Location({
    this.lat,
    this.lng,
  });

  factory PlacesDetailsDto$Location.fromJson(Map<String, dynamic> json) => _$PlacesDetailsDto$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesDetailsDto$LocationToJson(this);
}
