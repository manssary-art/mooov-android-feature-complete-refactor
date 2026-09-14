import 'package:json_annotation/json_annotation.dart';

import 'address_contact_dto.dart';
import 'geo_point_dto.dart';

part 'address_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class AddressDto {
  @JsonKey(name: 'streetAddress')
  final String streetAddress;
  @JsonKey(name: 'apartmentNumber')
  final String? apartmentNumber;
  @JsonKey(name: 'area')
  final String? area;
  @JsonKey(name: 'country')
  final String? countryCode;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'floor')
  final String? floor;
  @JsonKey(name: 'pinCode')
  final String? doorEntryCode;
  @JsonKey(name: 'zipCode')
  final String? zipCode;
  @JsonKey(name: 'elevator')
  final bool? hasElevator;
  @JsonKey(name: 'contact')
  final AddressContactDto? contact;
  @JsonKey(name: 'geoPoint')
  final GeoPointDto geoPoint;

  const AddressDto({
    required this.streetAddress,
    required this.apartmentNumber,
    required this.area,
    required this.countryCode,
    required this.city,
    required this.floor,
    required this.doorEntryCode,
    required this.zipCode,
    required this.hasElevator,
    required this.contact,
    required this.geoPoint,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}
