import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/di.dart';
import '../../../../models/order_address_model.dart';
import '../../../../models/order_model.dart';
import '../../../../models/order_price_recommendation_model.dart';
import '../../../../models/places_details_model.dart';
import '../../../../models/types/order_size_type.dart';
import '../../../../models/types/order_state_type.dart';
import '../../../../models/types/order_type.dart';
import '../../../../models/types/product_condition_type.dart';
import '../../../../repositories/upload/upload_repository.dart';
import '../../../../core/ext/riverpod_ext.dart';
import '../models/order_placement_address.dart';
import '../models/order_placement_mode.dart';
import '../models/order_placement_steps.dart';
import '../widgets/order_placement_content_address_form.dart' show floorPrice, assemblyPrice;

part 'order_placement_addresses_providers.dart';

part 'order_placement_final_price_providers.dart';

part 'order_placement_images_providers.dart';

part 'order_placement_side_effects_providers.dart';

part 'order_placement_state_providers.dart';

part 'order_placement_steps_providers.dart';

const _name = 'OrderPlacement';

final _scope = ProviderScopeContainer();

final uploadRepositoryProvider = Provider((ref) => Di.uploadRepository);

final orderRepositoryProvider = Provider((ref) => Di.orderRepository);

final orderPlacementRepositoryProvider =
    Provider((ref) => Di.orderPlacementRepository);

final orderPlacementProvider =
    AsyncNotifierProvider<OrderPlacementNotifier, (OrderType, OrderModel?)>(
  name: '$_name.initialOrderModelProvider',
  dependencies: _scope.dependencies,
  () => throw UnimplementedError(),
).scoped(_scope);

class OrderPlacementNotifier extends AsyncNotifier<(OrderType, OrderModel?)> {
  final OrderPlacementMode _mode;

  OrderPlacementNotifier(this._mode);

  @override
  FutureOr<(OrderType, OrderModel?)> build() async => switch (_mode) {
        OrderPlacementMode$New mode => Result.value((mode.orderType, null)),
        OrderPlacementMode$Edit mode => await ref
            .read(orderRepositoryProvider)
            .getOrderById(orderId: mode.orderId)
            .flatMapValue((order) => !mode.duplicate &&
                    order.orderState != OrderState.created
                ? Result.error(Exception(
                    'Not allowed to edit order in state ${order.orderState}'))
                : Result.value((order.orderType, order)))
      }
          .asValue!
          .value;
}
