import 'package:core/core.dart';
import 'package:network_api/dtos/places_auto_complete_dto.dart';
import 'package:network_api/dtos/places_details_dto.dart';

import '../geo_point_model.dart';
import '../places_auto_complete_model.dart';
import '../places_details_model.dart';

extension PlacesAutoCompleteDtoMapperExt on PlacesAutoCompleteDto {
  PlacesAutoCompleteModel? toPlacesAutoCompleteModelOrNull() {
    if (description == null) return null;
    if (placeId == null) return null;
    return PlacesAutoCompleteModel(
      description: description!,
      mainText: structuredFormatting?.mainText,
      placeId: placeId!,
    );
  }
}

extension PlacesDetailsDtoMapperExt on PlacesDetailsDto {
  PlacesDetailsModel? toPlacesDetailsModelOrNull() {
    String? number;
    String? streetAddress;
    double? lat = geometry?.location?.lat;
    double? lng = geometry?.location?.lng;
    String? countryCode;
    String? zipCode;
    String? area;
    String? city;

    for (final component in addressComponents ?? <PlacesDetailsDto$AddressComponent>[]) {
      final types = component.types ?? <String>[];

      if (types.any((type) => type.contains('street_number')) == true) {
        number ??= component.shortName ?? component.longName;
      }

      if (types.any((type) => type.contains('route')) == true) {
        streetAddress ??= component.shortName ?? component.longName;
      }

      if (types.any((type) => type.contains('sublocality')) == true) {
        area ??= component.shortName ?? component.longName;
      }

      if (types.any((type) => type.contains('country')) == true) {
        countryCode ??= component.shortName;
      }

      if (types.any((type) => type.contains('postal_code')) == true) {
        zipCode ??= component.shortName ?? component.longName;
      }

      if (types.any((type) => type.contains('city')) == true) {
        city ??= component.shortName ?? component.longName;
      }

      if (types.any((type) => type.contains('postal_town')) == true) {
        city = component.shortName ?? component.longName;
      }

      if (types.any((type) => type.contains('sublocality')) == true) {
        city ??= component.shortName ?? component.longName;
      }
      if (types.any((type) => type.contains('locality')) == true) {
        city ??= component.shortName ?? component.longName;
      }
    }

    if (streetAddress == null) {
      streetAddress = formattedAddress;
    } else if (number != null) {
      streetAddress = "$streetAddress $number";
    }

    if (streetAddress == null || lat == null || lng == null) {
      return null;
    }

    return PlacesDetailsModel(
      streetAddress: streetAddress,
      geoPoint: GeoPointModel(latitude: lat, longitude: lng),
      zipCode: zipCode,
      city: city,
      area: area,
      country: countryCode?.toCountryOrNull(),
    );
  }
}
