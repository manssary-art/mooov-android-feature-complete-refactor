import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/ext/riverpod_ext.dart';
import '../../../../di/di.dart';
import '../../../../models/geo_point_model.dart';
import '../../../../models/order_model.dart';
import '../../../../models/types/order_state_type.dart';
import '../../../../models/types/user_role_type.dart';
import '../../../../models/user_model.dart';
import '../../../../repositories/user/user_repository.dart';
import '../models/order_details_display_mode.dart';

part 'order_details_owner_providers.dart';

part 'order_details_providers.dart';

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
