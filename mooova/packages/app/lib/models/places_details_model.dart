import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'geo_point_model.dart';

class PlacesDetailsModel with EquatableMixin {
  final String? streetAddress;
  final GeoPointModel? geoPoint;
  final String? city;
  final Country? country;
  final String? zipCode;
  final String? area;

  PlacesDetailsModel({
    this.streetAddress,
    this.geoPoint,
    this.city,
    this.country,
    this.zipCode,
    this.area,
  });

  @override
  List<Object?> get props => [
        streetAddress,
        geoPoint,
        city,
        country,
        zipCode,
        area,
      ];
}
