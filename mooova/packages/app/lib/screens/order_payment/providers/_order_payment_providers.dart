import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/di.dart';
import '../../../../models/payment_intent_model.dart';
import '../../../../models/types/payment_method_type.dart';
import '../../../../core/ext/riverpod_ext.dart';
import '../models/available_payment_methods.dart';
import '../models/order_payment_model.dart';
import '../models/order_payment_screen_params.dart';
import '../models/order_payment_step.dart';

part 'order_payment_providers.dart';

part 'order_payment_side_effects_providers.dart';

part 'order_payment_state_providers.dart';

const _name = 'OrderPayment';

final _scope = ProviderScopeContainer();

final savedPaymentMethodRepositoryProvider = Provider((ref) => Di.savedPaymentMethodRepository);

final placePaymentRepositoryProvider = Provider((ref) => Di.placePaymentRepository);

final orderCandidateRepositoryProvider = Provider((ref) => Di.orderCandidateRepository);

final orderRepositoryProvider = Provider((ref) => Di.orderRepository);

final userRepositoryProvider = Provider((ref) => Di.userRepository);
