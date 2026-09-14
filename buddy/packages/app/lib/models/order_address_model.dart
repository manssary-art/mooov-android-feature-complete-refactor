import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'geo_point_model.dart';

class OrderAddressModel with EquatableMixin {
  final String? streetAddress;
  final String? area;
  final String? city;
  final String? floor;
  final String? doorEntryCode;
  final String? zipCode;
  final bool? hasElevator;
  final String? contactPhone;
  final GeoPointModel? geoPoint;
  final Country? country;

  const OrderAddressModel({
    required this.streetAddress,
    required this.area,
    required this.city,
    required this.floor,
    required this.doorEntryCode,
    required this.zipCode,
    required this.hasElevator,
    required this.contactPhone,
    required this.geoPoint,
    required this.country,
  });

  factory OrderAddressModel.empty() => const OrderAddressModel(
        streetAddress: null,
        area: null,
        city: null,
        floor: null,
        doorEntryCode: null,
        zipCode: null,
        hasElevator: null,
        contactPhone: null,
        geoPoint: null,
        country: null,
      );

  @override
  List<Object?> get props => [
        streetAddress,
        area,
        city,
        floor,
        doorEntryCode,
        zipCode,
        hasElevator,
        contactPhone,
        geoPoint,
        country,
      ];

  OrderAddressModel copyWith({
    String Function()? streetAddress,
    String? Function()? apartmentNumber,
    String? Function()? area,
    Country? Function()? country,
    String? Function()? city,
    String? Function()? floor,
    String? Function()? doorEntryCode,
    String? Function()? zipCode,
    bool? Function()? hasElevator,
    String? Function()? contactPhone,
    GeoPointModel Function()? geoPoint,
  }) {
    return OrderAddressModel(
      streetAddress: streetAddress != null ? streetAddress() : this.streetAddress,
      area: area != null ? area() : this.area,
      city: city != null ? city() : this.city,
      floor: floor != null ? floor() : this.floor,
      doorEntryCode: doorEntryCode != null ? doorEntryCode() : this.doorEntryCode,
      zipCode: zipCode != null ? zipCode() : this.zipCode,
      hasElevator: hasElevator != null ? hasElevator() : this.hasElevator,
      contactPhone: contactPhone != null ? contactPhone() : this.contactPhone,
      geoPoint: geoPoint != null ? geoPoint() : this.geoPoint,
      country: country != null ? country() : this.country,
    );
  }
}

extension OrderAddressModelFormattedExt on OrderAddressModel {
  String get displayAddress => ''.appendMaybe(streetAddress).appendMaybe(area).appendMaybe(city).appendMaybe(zipCode);

  String get displayAddressObfuscated => ''.appendMaybe(city);

  bool get isFilled => streetAddress != null && geoPoint != null;
}

extension on String {
  String appendMaybe(String? value) {
    if (value != null && value.isNotEmpty) {
      return this + (this != '' ? ', ' : '') + value;
    } else {
      return this;
    }
  }
}
