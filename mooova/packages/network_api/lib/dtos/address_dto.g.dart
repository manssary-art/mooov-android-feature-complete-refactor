// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => AddressDto(
      streetAddress: json['streetAddress'] as String,
      apartmentNumber: json['apartmentNumber'] as String?,
      area: json['area'] as String?,
      countryCode: json['country'] as String?,
      city: json['city'] as String?,
      floor: json['floor'] as String?,
      doorEntryCode: json['pinCode'] as String?,
      zipCode: json['zipCode'] as String?,
      hasElevator: json['elevator'] as bool?,
      contact: json['contact'] == null
          ? null
          : AddressContactDto.fromJson(json['contact'] as Map<String, dynamic>),
      geoPoint: GeoPointDto.fromJson(json['geoPoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressDtoToJson(AddressDto instance) {
  final val = <String, dynamic>{
    'streetAddress': instance.streetAddress,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('apartmentNumber', instance.apartmentNumber);
  writeNotNull('area', instance.area);
  writeNotNull('country', instance.countryCode);
  writeNotNull('city', instance.city);
  writeNotNull('floor', instance.floor);
  writeNotNull('pinCode', instance.doorEntryCode);
  writeNotNull('zipCode', instance.zipCode);
  writeNotNull('elevator', instance.hasElevator);
  writeNotNull('contact', instance.contact);
  val['geoPoint'] = instance.geoPoint;
  return val;
}
