part of '_home_providers.dart';

final userLocationProvider = StreamNotifierProvider<HomeUserLocationNotifier, String?>(
  name: '$_name.userLocationProvider',
  dependencies: _scope.dependencies,
  () => HomeUserLocationNotifier(),
).scoped(_scope);

class HomeUserLocationNotifier extends StreamNotifier<String?> {
  GeoPointModel? _lastRequest;

  @override
  Stream<String?> build() async* {
    final locationService = ref.watch(locationServiceProvider);
    final placesRepository = ref.watch(placesRepositoryProvider);
    yield* Stream.periodic(const Duration(minutes: 1))
        .asyncMap((e) async {
          var location = locationService.lastKnowLocation;
          location ??= await locationService.requestLocation(requestPermission: false);
          return location;
        })
        .whereNotNull()
        .asyncMap((e) async {
          if (state.valueOrNull != null && _lastRequest != null) {
            if (5 < calculateDistance(e.latitude, e.longitude, _lastRequest!.latitude, _lastRequest!.longitude)) {
              return state.valueOrNull;
            }
          }

          final result = await placesRepository.getPlacesDetailsByCoordinates(lat: e.latitude, lng: e.longitude);
          final details = result.asValue?.value;
          if (details == null || (details.city == null && details.country == null)) return null;
          _lastRequest = e;
          if (details.city != null && details.country == null) return details.city;
          if (details.city == null && details.country != null) return details.country?.name;
          return "${details.city}, ${details.country}";
        });
  }
}
