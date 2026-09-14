import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/di.dart';
import '../../../../models/explore_ads_model.dart';
import '../../../../models/order_model.dart';
import '../../../../core/ext/riverpod_ext.dart';
import '../models/explore_tab.dart';

part 'explore_ads_providers.dart';

part 'explore_side_effects_providers.dart';

part 'explore_state_providers.dart';

const _name = 'Explore';

final _scope = ProviderScopeContainer();

final orderDiscoveryRepositoryProvider =
    Provider((ref) => Di.orderDiscoveryRepository);

final adsRepositoryProvider = Provider((ref) => Di.adsRepository);

final exploreProvider =
    StreamNotifierProvider<ExploreNotifier, List<OrderModel>>(
  name: '$_name.orderDetailsProvider',
  dependencies: _scope.dependencies,
  () => ExploreNotifier(),
).scoped(_scope);

class ExploreNotifier extends StreamNotifier<List<OrderModel>> {
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  Stream<List<OrderModel>> build() async* {
    final orderDiscoveryRepository =
        ref.watch(orderDiscoveryRepositoryProvider);
    final startWithOrdersResult = await orderDiscoveryRepository
        .getNearbyOrders(requestPermission: false);
    yield* orderDiscoveryRepository.onNearbyOrdersChanged
        .startWith(startWithOrdersResult.asValue!.value);
  }

  void onPullToRefresh() async {
    if (state.isLoading || state.isRefreshing) return;
    ref.invalidateSelf();
  }

  void onOrderClicked(
    String orderId,
  ) async {
    _sideEffect().add(ExploreSideEffect$NavToOrderDetails(orderId: orderId));
  }
}
