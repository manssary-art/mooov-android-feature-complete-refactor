part of '_order_details_providers.dart';

final userLocationProvider = NotifierProvider<OrderDetailsUserLocationNotifier, GeoPointModel?>(
  name: '$_name.descriptionProvider',
  dependencies: _scope.dependencies,
  () => OrderDetailsUserLocationNotifier(),
).scoped(_scope);

class OrderDetailsUserLocationNotifier extends Notifier<GeoPointModel?> {
  @override
  GeoPointModel? build() {
    return null;
  }
}
