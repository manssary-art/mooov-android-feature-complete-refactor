import 'dart:math';

import '../../models/geo_point_model.dart';

class GeoPointBounds {
  final GeoPointModel northeast;
  final GeoPointModel southwest;

  GeoPointBounds({
    required this.northeast,
    required this.southwest,
  });
}

/// Return a list of 2 items: [northeast,  southwest]
GeoPointBounds boundsFromGeoPointList(
  List<GeoPointModel> list,
) {
  assert(list.isNotEmpty);
  double? x0, x1, y0, y1;
  for (final geoPoint in list) {
    if (x0 == null) {
      x0 = x1 = geoPoint.latitude;
      y0 = y1 = geoPoint.longitude;
    } else {
      if (x1 != null && geoPoint.latitude > x1) x1 = geoPoint.latitude;
      if (geoPoint.latitude < x0) x0 = geoPoint.latitude;
      if (y1 != null && geoPoint.longitude > y1) y1 = geoPoint.longitude;
      if (y0 != null && geoPoint.longitude < y0) y0 = geoPoint.longitude;
    }
  }
  return GeoPointBounds(
    northeast: GeoPointModel(latitude: x1!, longitude: y1!),
    southwest: GeoPointModel(latitude: x0!, longitude: y0!),
  );
}

double calculateDistance(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

double calculateMaxDistance(
  List<GeoPointModel> geoPoints,
) {
  double maxDistance = 0;
  for (int i = 0; i < geoPoints.length; i++) {
    final geoPoint1 = geoPoints[i];
    for (int j = i; j < geoPoints.length; j++) {
      final geoPoint2 = geoPoints[j];
      final dist = calculateDistance(
        geoPoint1.latitude,
        geoPoint1.longitude,
        geoPoint2.latitude,
        geoPoint2.longitude,
      );
      maxDistance = dist > maxDistance ? dist : maxDistance;
    }
  }

  return maxDistance;
}
