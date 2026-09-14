import '../../models/explore_ads_model.dart';

abstract interface class AdsRepository {
  Stream<ExploreAdsModel> get onExploreAdsChanged;
}
