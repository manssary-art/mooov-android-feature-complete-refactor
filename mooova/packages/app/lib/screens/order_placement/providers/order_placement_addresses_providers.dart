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

  void onAssemblyToggled(int key, bool value) async {
    state = state.mapIndexed((i, e) {
      if (i != key) return e;
      return e.copyWith(assembly: () => value);
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

  void onDeleteAddressClicked(int key) async {
    state = state.asMap().entries.where((entry) => entry.key != key).map((entry) => entry.value).toList();
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

final totalFloorCostProvider = Provider<double>(
  name: '$_name.totalFloorCostProvider',
  dependencies: _scope.dependencies,
  (ref) {
    final addresses = ref.watch(addressesProvider);

    return addresses.fold<double>(0.0, (sum, address) {
      if (address.hasElevator ?? false) return sum;
      if (address.country == null) return sum;

      final pricePerFloor = floorPrice.floorPerLvelPrice(address.country!.code);
      if (pricePerFloor == null) return sum;

      final floorNumber = int.tryParse(address.floor ?? '1') ?? 1;
      return sum + (pricePerFloor * floorNumber);
    });
  },
).scoped(_scope);

final totalAssemblyCostProvider = Provider<double>(
  name: '$_name.totalAssemblyCostProvider',
  dependencies: _scope.dependencies,
  (ref) {
    final addresses = ref.watch(addressesProvider);
    final pickupAddress = addresses.getAtOrNull(pickUpAddressKey);

    if (pickupAddress == null || pickupAddress.assembly != true) return 0.0;
    if (pickupAddress.country == null) return 0.0;

    return assemblyPrice.priceForCountry(pickupAddress.country!.code) ?? 0.0;
  },
).scoped(_scope);

final additionalFeesProvider = Provider<double>(
  name: '$_name.additionalFeesProvider',
  dependencies: _scope.dependencies,
  (ref) => ref.watch(totalFloorCostProvider) + ref.watch(totalAssemblyCostProvider),
).scoped(_scope);
