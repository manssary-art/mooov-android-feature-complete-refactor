import '../../models/geo_point_model.dart';

abstract interface class LocationService {
  GeoPointModel? get lastKnowLocation;

  Future<GeoPointModel?> requestLocation({
    bool requestPermission = true,
  });

  Future<bool> getLocationPermission({
    bool requestPermission = false,
  });
}
