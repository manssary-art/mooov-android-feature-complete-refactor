import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/geo_point_model.dart';
import '../storage/key_value_storage.dart';
import 'location_service.dart';

final _requestPermissionEmpty =
    MapEntry(0, Future.value(LocationPermission.denied));

class LocationServiceImpl implements LocationService {
  final KeyValueStorage storage;

  LocationServiceImpl({
    required this.storage,
  }) {
    _onStart();
  }

  @override
  GeoPointModel? lastKnowLocation;

  MapEntry<int, Future<LocationPermission>> _requestPermission =
      _requestPermissionEmpty;

  Future<void> _onStart() async {
    final latitude = await storage.getDouble('GeoLocationServiceImpl.latitude');
    final longitude =
        await storage.getDouble('GeoLocationServiceImpl.longitude');
    if (latitude != null && longitude != null) {
      lastKnowLocation =
          GeoPointModel(latitude: latitude, longitude: longitude);
    }
  }

  @override
  Future<bool> getLocationPermission({
    bool requestPermission = true,
  }) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.isGranted) {
      return true;
    }

    if (requestPermission) {
      try {
        if (_requestPermission.key == 0) {
          _requestPermission = MapEntry(1, Geolocator.requestPermission());
        }

        permission = await _requestPermission.value;
      } finally {
        _requestPermission = _requestPermissionEmpty;
      }
    }

    return permission.isGranted;
  }

  @override
  Future<GeoPointModel?> requestLocation({
    bool requestPermission = true,
  }) async {
    final granted = await getLocationPermission(
      requestPermission: requestPermission,
    );

    if (!granted) {
      return lastKnowLocation;
    }

    Position? position;

    try {
      position = await Geolocator.getLastKnownPosition();
    } on PlatformException catch (_) {
      // Ignore
    }

    try {
      position ??= await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on PlatformException catch (_) {
      // Ignore
    }

    if (position == null) {
      return lastKnowLocation;
    }

    return position
        .let((it) =>
            GeoPointModel(latitude: it.latitude, longitude: it.longitude))
        .also((it) async {
      lastKnowLocation = it;
      await storage.setDouble('GeoLocationServiceImpl.latitude', it.latitude);
      await storage.setDouble('GeoLocationServiceImpl.longitude', it.longitude);
    });
  }
}

extension on LocationPermission {
  bool get isGranted {
    switch (this) {
      case LocationPermission.denied:
        return false;
      case LocationPermission.deniedForever:
        return false;
      case LocationPermission.whileInUse:
        return true;
      case LocationPermission.always:
        return true;
      case LocationPermission.unableToDetermine:
        return true;
    }
  }
}
