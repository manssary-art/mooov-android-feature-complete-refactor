import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../models/order_address_model.dart';

void Function(OrderAddressModel address) useOpenOnExternalMap() {
  return useCallback((address) async {
    if (address.geoPoint == null) return;

    MapType type = MapType.google;
    final isAvailable = await MapLauncher.isMapAvailable(type);
    if (isAvailable == false) {
      final availableMaps = await MapLauncher.installedMaps;
      type = availableMaps.first.mapType;
    }

    await MapLauncher.showMarker(
      mapType: type,
      coords: Coords(address.geoPoint!.latitude, address.geoPoint!.longitude),
      title: address.streetAddress ?? '',
    );
  }, []);
}

