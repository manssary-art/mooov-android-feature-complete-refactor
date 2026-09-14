import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ext/riverpod_ext.dart';
import '../../../../di/di.dart';
import '../../../../models/order_model.dart';

part 'order_rating_providers.dart';
part 'order_rating_state_providers.dart';
part 'order_rating_side_effects_providers.dart';
part 'order_rating_action_providers.dart';

const _name = 'OrderRating';

final _scope = ProviderScopeContainer();

final orderRepositoryProvider = Provider((ref) => Di.orderRepository);
final orderRatingRepositoryProvider = Provider((ref) => Di.orderRatingRepository);
