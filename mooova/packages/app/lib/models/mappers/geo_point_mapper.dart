import 'package:network_api/dtos/geo_point_dto.dart';

import '../geo_point_model.dart';

extension GeoPointDtoMapperExt on GeoPointDto {
  GeoPointModel toGeoPointModel() => GeoPointModel(
        latitude: latitude,
        longitude: longitude,
      );
}
