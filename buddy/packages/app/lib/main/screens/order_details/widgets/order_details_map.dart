import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/geo_point_model.dart';
import '../../../../models/order_address_model.dart';
import '../../../../models/types/order_type.dart';
import '../../../../services/location/location_utils.dart';

class OrderDetailsMap extends HookWidget {
  final OrderType category;
  final OrderAddressModel pickupAddress;
  final List<OrderAddressModel> deliveryAddresses;
  final GeoPointModel? userLocation;

  const OrderDetailsMap({
    super.key,
    required this.category,
    required this.pickupAddress,
    required this.deliveryAddresses,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    final isAnimationDone = useState<bool>(false);
    final mapController = useState<GoogleMapBuilderController?>(null);
    final centerCamera = useCallback((Set<Marker>? markers) async {
      final controller = mapController.value;
      if (controller == null || markers == null || markers.isEmpty) {
        return;
      }

      final latLngs = markers.map((e) => e.position).toList();
      if (category == OrderType.giveAway) {
        final cameraBounds = CameraUpdate.newLatLngZoom(latLngs.first, 14.0);
        await Future.delayed(const Duration(milliseconds: 500));
        controller.animateCamera(cameraBounds);
      } else {
        final geoPoints = latLngs.map((e) => e.toGeoPointModel()).toList();
        final bounds = boundsFromGeoPointList(geoPoints);
        final cameraBounds = CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: bounds.northeast.toLatLng(),
            southwest: bounds.southwest.toLatLng(),
          ),
          40.0,
        );
        await Future.delayed(const Duration(milliseconds: 500));
        controller.animateCamera(cameraBounds);
      }
    }, [mapController, category]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.Map.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            height: 240,
            width: double.infinity,
            color: Theme.of(context).colorScheme.surface,
            constraints: const BoxConstraints(minHeight: 120),
            child: FutureBuilder<Set<Marker>>(
              future: Future.sync(() async {
                final pickUp = pickupAddress.geoPoint;
                final geoPoints = [
                  pickUp,
                  if (category != OrderType.giveAway) ...[
                    ...deliveryAddresses.map((e) => e.geoPoint),
                  ],
                ];

                const size = kIsWeb ? 16.0 : 4.0;
                const config = ImageConfiguration(size: Size.square(size));
                final futures = <Future<Marker?>>[];
                if (userLocation != null) {
                  futures.add(
                    Future.microtask(() async => Marker(
                          markerId: const MarkerId('workerLocation'),
                          position: userLocation!.toLatLng(),
                          icon: await BitmapDescriptor.fromAssetImage(
                            config,
                            Assets.images.iconVanMarker.path,
                          ),
                        )),
                  );
                }

                for (var i = 0; i < geoPoints.length; i++) {
                  final index = i;
                  final assetName = index.toMapMarkerAsset(deliveryAddresses.length > 1);
                  final geoPoint = geoPoints[i];
                  if (geoPoint == null) continue;
                  futures.add(
                    Future.microtask(() async => Marker(
                          markerId: MarkerId('$index'),
                          position: geoPoint.toLatLng(),
                          icon: await BitmapDescriptor.fromAssetImage(config, assetName.path),
                        )),
                  );
                }

                final results = await Future.wait(futures);
                await Future.delayed(const Duration(milliseconds: 500));
                return results.toSet().mapNotNull((e) => e).cast<Marker>().toSet();
              }),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: LoadingIndicator(),
                  );
                }

                return Stack(
                  children: [
                    GoogleMapBuilder(
                      myLocationEnabled: false,
                      forceRefreshEnabled: false,
                      markers: snap.data ?? <Marker>{},
                      gestureRecognizers: {
                        Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
                        Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
                        Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
                      },
                      initialCameraPosition: CameraPosition(
                        target: snap.data!.first.position,
                      ),
                      zoomGesturesEnabled: false,
                      onMapCreated: (controller) async {
                        mapController.value = controller;
                        centerCamera(snap.data);
                      },
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: InkWell(
                        onTap: () => centerCamera(snap.data),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: const Icon(
                            Icons.gps_fixed,
                            color: ColorName.info,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    if (!isAnimationDone.value) ...[
                      AnimatedOpacity(
                        onEnd: () => isAnimationDone.value = true,
                        opacity: mapController.value == null ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

extension on int {
  static final _addressMarkers = <AssetGenImage>[
    Assets.images.iconMarkerPickUp,
    Assets.images.iconMarkerDropOff,
  ].asMap();

  static final _multiAddressMarkers = <AssetGenImage>[
    Assets.images.iconMarker0,
    Assets.images.iconMarker1,
    Assets.images.iconMarker2,
    Assets.images.iconMarker3,
    Assets.images.iconMarker4,
    Assets.images.iconMarker5,
    Assets.images.iconMarker6,
    Assets.images.iconMarker7,
    Assets.images.iconMarker8,
    Assets.images.iconMarker9,
    Assets.images.iconMarker10,
    Assets.images.iconMarker11,
    Assets.images.iconMarker12,
  ].asMap();

  AssetGenImage toMapMarkerAsset(bool isMultiAddress) {
    if (isMultiAddress) {
      return _multiAddressMarkers[this] ?? Assets.images.iconMarkerDropOff;
    } else {
      return _addressMarkers[this] ?? Assets.images.iconMarkerDropOff;
    }
  }
}

extension on GeoPointModel {
  LatLng toLatLng() => LatLng(
        latitude,
        longitude,
      );
}

extension on LatLng {
  GeoPointModel toGeoPointModel() => GeoPointModel(
        latitude: latitude,
        longitude: longitude,
      );
}
