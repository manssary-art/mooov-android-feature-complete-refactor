import 'package:flutter/material.dart';

import '../../../../models/geo_point_model.dart';
import '../../../../models/order_address_model.dart';
import '../../../../services/location/location_utils.dart';

class OrderDetailsDistance extends StatelessWidget {
  final int? distance;
  final String text;

  const OrderDetailsDistance({
    super.key,
    required this.distance,
    required this.text,
  });

  factory OrderDetailsDistance.realtime({
    required String text,
    required OrderAddressModel address,
    required GeoPointModel? userLocation,
  }) {
    final lat = address.geoPoint?.latitude;
    final lon = address.geoPoint?.longitude;
    final cLat = userLocation?.latitude;
    final cLon = userLocation?.longitude;

    int? distance;
    if (lat != null && lon != null && cLat != null && cLon != null) {
      distance = calculateDistance(lat, lon, cLat, cLon).toInt();
    }

    return OrderDetailsDistance(distance: distance, text: text);
  }

  @override
  Widget build(BuildContext context) {
    final distance = this.distance;
    if (distance == null) {
      return Container();
    }

    String distanceValue;
    String scale = 'm';
    int value = distance;
    if (distance > 1000) {
      scale = 'km';
      value = distance ~/ 1000;
    }

    distanceValue = '${value.toStringAsFixed(0)} $scale';
    return SizedBox(
      width: double.infinity,
      child: Text(
        '$text $distanceValue',
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
