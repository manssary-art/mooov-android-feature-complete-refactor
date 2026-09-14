import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/di.dart';
import '../../../../models/user_model.dart';
import '../../../../core/ext/riverpod_ext.dart';

part 'order_worker_selection_pickup_time_providers.dart';

part 'order_worker_selection_side_effects_providers.dart';

part 'order_worker_selection_state_providers.dart';

const _name = 'OrderWorkerSelection';

final _scope = ProviderScopeContainer();

final orderRepositoryProvider = Provider((ref) => Di.orderRepository);

final userRepositoryProvider = Provider((ref) => Di.userRepository);

final orderCandidateRepositoryProvider = Provider((ref) => Di.orderCandidateRepository);

final orderWorkerSelectionProvider =
    StreamNotifierProvider<OrderWorkerSelectionNotifier, List<(UserModel, List<DateTime>)>>(
  name: '$_name.OrderWorkerSelectionProvider',
  dependencies: _scope.dependencies,
  () => throw UnimplementedError(),
).scoped(_scope);

class OrderWorkerSelectionNotifier extends StreamNotifier<List<(UserModel, List<DateTime>)>> {
  final String orderId;

  OrderWorkerSelectionNotifier(this.orderId);

  late final _selectedPickupTime = () => ref.read(selectedPickupTimeProvider);
  late final _sideEffect = () => ref.read(sideEffectProvider);

  @override
  Stream<List<(UserModel, List<DateTime>)>> build() async* {
    final userRepository = ref.watch(userRepositoryProvider);
    final orderRepository = ref.watch(orderRepositoryProvider);
    final startWithUserResult = await userRepository.getUser();
    final startWithOderResult = await orderRepository.getOrderById(
      orderId: orderId,
    );

    yield* Rx.combineLatest2(
      userRepository.onUserChanged.startWith(startWithUserResult.asValue!.value),
      orderRepository.onOrderChanged.where((e) => e.orderId == orderId).startWith(startWithOderResult.asValue!.value),
      (user, order) {
        if (order.owner.userId != user.userId) {
          throw Exception('Current user is not the order owner');
        }
        return order.candidates!.entries.map((e) => (e.key, e.value)).toList();
      },
    );
  }

  void onNavBackClicked() async {
    _sideEffect().add(const OrderWorkerSelectionSideEffect$NavBack());
  }

  void onTryAgainClicked() async {
    if (state.hasError) {
      ref.invalidateSelf();
    }
  }

  void onSubmitClicked() async {
    final selected = _selectedPickupTime();
    if (selected == null) return;
    _sideEffect().add(OrderWorkerSelectionSideEffect$NavToPayment(selected.$1, selected.$2));
  }
}
