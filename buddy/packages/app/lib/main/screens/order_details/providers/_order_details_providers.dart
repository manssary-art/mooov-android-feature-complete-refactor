import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/di.dart';
import '../../../../models/geo_point_model.dart';
import '../../../../models/order_model.dart';
import '../../../../models/types/order_state_type.dart';
import '../../../../models/types/user_role_type.dart';
import '../../../../models/user_model.dart';
import '../../../../repositories/user/user_repository.dart';
import '../../../core/riverpod_ext.dart';
import '../models/order_details_display_mode.dart';

part 'order_details_owner_providers.dart';

part 'order_details_side_effects_providers.dart';

part 'order_details_state_providers.dart';

part 'order_details_translated_description_providers.dart';

part 'order_details_user_location_providers.dart';

part 'order_details_worker_providers.dart';

const _name = 'OrderDetails';

final _scope = ProviderScopeContainer();

final translateRepositoryProvider = Provider((ref) => Di.translateRepository);

final orderRepositoryProvider = Provider((ref) => Di.orderRepository);

final deepLinksRepositoryProvider = Provider((ref) => Di.deepLinksRepository);

final userRepositoryProvider = Provider((ref) => Di.userRepository);

final orderCandidateRepositoryProvider = Provider((ref) => Di.orderCandidateRepository);

final orderDetailsProvider = StreamNotifierProvider<OrderDetailsNotifier, (UserModel? user, OrderModel order)>(
  name: '$_name.orderDetailsProvider',
  dependencies: _scope.dependencies,
  () => throw UnimplementedError(),
).scoped(_scope);

class OrderDetailsNotifier extends StreamNotifier<(UserModel? user, OrderModel order)> {
  final String orderId;

  OrderDetailsNotifier(this.orderId);

  late final _sideEffect = () => ref.read(sideEffectProvider);
  late final _deepLinksRepository = () => ref.read(deepLinksRepositoryProvider);

  @override
  Stream<(UserModel? user, OrderModel order)> build() async* {
    final userRepository = ref.watch(userRepositoryProvider);
    final orderRepository = ref.watch(orderRepositoryProvider);
    final startWithUserResult = await userRepository.getUserOrNull();
    final startWithOderResult = await orderRepository.getOrderById(
      orderId: orderId,
    );

    yield* Rx.combineLatest2(
      userRepository.onUserChanged.cast<UserModel?>().startWith(startWithUserResult.asValue!.value),
      orderRepository.onOrderChanged.where((e) => e.orderId == orderId).startWith(startWithOderResult.asValue!.value),
      (user, order) => (user, order),
    );
  }

  void onNavBackClicked() async {
    _sideEffect().add(const OrderDetailsSideEffect$NavBack());
  }

  void onShareClicked() async {
    await _deepLinksRepository()
        .getDeepLinkForOrderId(orderId: orderId)
        .onValue((e) => _sideEffect().add(OrderDetailsSideEffect$ShareUrl(url: e)));
  }
}
