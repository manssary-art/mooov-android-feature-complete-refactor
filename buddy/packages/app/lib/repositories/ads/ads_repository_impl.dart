import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/explore_ads_model.dart';
import '../../models/mappers/explore_ads_mapper.dart';
import 'ads_repository.dart';

class AdsRepositoryImpl implements AdsRepository {
  final FirebaseDatabase firebaseDatabase;

  AdsRepositoryImpl({
    required this.firebaseDatabase,
  });

  bool hasStarted = false;

  final _onExploreAdsChanged = BehaviorSubject<ExploreAdsModel>();

  @override
  Stream<ExploreAdsModel> get onExploreAdsChanged => _onExploreAdsChanged.stream.also((_) => _onStart());

  void _onStart() async {
    if (hasStarted) return;
    hasStarted = true;
    firebaseDatabase
        .ref()
        .child('ad_discover_tab')
        .onValue
        .asyncMap((e) => resultOf(() => Result.value(e.snapshot.toExploreAdsModelOrNull())))
        .mapNotNull((e) => e.asValue?.value)
        .listen((e) => _onExploreAdsChanged.add(e));
  }
}
