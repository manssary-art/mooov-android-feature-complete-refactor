part of '_home_providers.dart';

final bannerProvider = StreamNotifierProvider<HomeBannerNotifier, String?>(
  name: '$_name.bannerProvider',
  dependencies: _scope.dependencies,
  () => HomeBannerNotifier(),
).scoped(_scope);

class HomeBannerNotifier extends StreamNotifier<String?> {
  @override
  Stream<String?> build() async* {
    final firebaseDatabase = ref.watch(firebaseDatabaseProvider);
    final locale = ref.watch(localeProvider);
    if (locale != null) {
      yield* firebaseDatabase
          .ref('ad_info/${locale.toLowerCase()}')
          .onValue
          .map((e) => e.snapshot.value)
          .where((e) => e is String)
          .cast<String>();
    }
  }
}
