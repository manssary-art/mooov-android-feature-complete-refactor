part of '_order_placement_providers.dart';

typedef Addresses = ({OrderAddressModel pickUpAddress, List<OrderAddressModel> deliveryAddreses});

final addressesProvider = NotifierProvider<OrderPlacementAddressesNotifier, List<OrderAddressModel>>(
  name: '$_name.addressesProvider',
  dependencies: _scope.dependencies,
  () => OrderPlacementAddressesNotifier(),
).scoped(_scope);

class OrderPlacementAddressesNotifier extends Notifier<List<OrderAddressModel>> {
  @override
  List<OrderAddressModel> build() {
    final initialOrderModel = ref.watch(orderPlacementProvider).value;
    final addresses = <OrderAddressModel>[];
    if (initialOrderModel == null) return addresses;
    addresses.add(initialOrderModel.$2?.pickupAddress ?? OrderAddressModel.empty());
    if (initialOrderModel.$1 != OrderType.giveAway) {
      final deliveryAddresses = initialOrderModel.$2?.deliveryAddresses?.takeIf((it) => it.isNotEmpty);
      addresses.addAll(deliveryAddresses ?? [OrderAddressModel.empty()]);
    }
    return addresses;
  }

  void onStreetAddressClicked(int key) async {
    ref.read(sideEffectProvider).add(OrderPlacementSideEffect$NavToAddressPicker(key));
  }

  void onHasElevatorToggled(int key, bool value) async {
    state = state.mapIndexed((i, e) {
      if (i != key) return e;
      return e.copyWith(hasElevator: () => value);
    }).toList();
  }

  void onFloorContentChanged(int key, String value) async {
    state = state.mapIndexed((i, e) {
      if (i != key) return e;
      return e.copyWith(floor: () => value);
    }).toList();
  }

  void onContactPhoneContentChanged(int key, String value) async {
    state = state.mapIndexed((i, e) {
      if (i != key) return e;
      return e.copyWith(contactPhone: () => value);
    }).toList();
  }

  void onDoorCodeContentChanged(int key, String value) async {
    state = state.mapIndexed((i, e) {
      if (i != key) return e;
      return e.copyWith(doorEntryCode: () => value);
    }).toList();
  }

  void onAddDeliveryAddressClicked() async {
    if (state.length > 10) return;
    state = state.plus(OrderAddressModel.empty());
  }

  void onAddressPicked(int key, PlacesDetailsModel picked) async {
    if (picked.country == null || picked.geoPoint == null || picked.streetAddress == null) return;
    state = state.mapIndexed((i, e) {
      if (i != key) return e;
      return e.copyWith(
        streetAddress: () => picked.streetAddress!,
        geoPoint: () => picked.geoPoint!,
        area: () => picked.area,
        city: () => picked.city,
        country: () => picked.country!,
        zipCode: () => picked.zipCode,
      );
    }).toList();
  }
}
