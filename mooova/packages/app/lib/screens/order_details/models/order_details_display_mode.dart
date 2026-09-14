
import 'package:equatable/equatable.dart';

import '../../../../models/types/user_role_type.dart';

sealed class OrderDetailsDisplayMode with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class OrderDetailsDisplayMode$Owner extends OrderDetailsDisplayMode {}

class OrderDetailsDisplayMode$Visitor extends OrderDetailsDisplayMode {
  final UserRole? role;

  OrderDetailsDisplayMode$Visitor(this.role);

  @override
  List<Object?> get props => [role];
}

class OrderDetailsDisplayMode$WorkerApplied extends OrderDetailsDisplayMode {
  final List<DateTime> appliedPickupTimes;

  OrderDetailsDisplayMode$WorkerApplied(this.appliedPickupTimes);

  @override
  List<Object?> get props => [appliedPickupTimes];
}

class OrderDetailsDisplayMode$WorkerAssigned extends OrderDetailsDisplayMode {
  final DateTime finalPickupTime;

  OrderDetailsDisplayMode$WorkerAssigned(this.finalPickupTime);

  @override
  List<Object?> get props => [finalPickupTime];
}