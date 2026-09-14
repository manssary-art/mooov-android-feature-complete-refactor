part of '_explore_providers.dart';

final exploreAdsProvider = StreamNotifierProvider<ExploreAdsNotifier, ExploreAdsModel?>(
  name: '$_name.exploreAdsProvider',
  dependencies: _scope.dependencies,
  () => ExploreAdsNotifier(),
).scoped(_scope);

class ExploreAdsNotifier extends StreamNotifier<ExploreAdsModel?> {
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  Stream<ExploreAdsModel> build() async* {
    final adsRepository = ref.watch(adsRepositoryProvider);
    yield* adsRepository.onExploreAdsChanged;
  }

  void onAdClicked(
    ExploreAdModelAction value,
  ) async {
    switch (value) {
      case ExploreAdModelAction$NavToProfile():
        _sideEffect().add(const ExploreSideEffect$NavToProfile());
        break;
      case ExploreAdModelAction$OpenUrl():
        _sideEffect().add(ExploreSideEffect$OpenUrl(url: value.url));
        break;
    }
  }
}
