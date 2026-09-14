
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/order_model.dart';

/// Order state

sealed class ActivitiesOrderItem with EquatableMixin {
  final OrderModel order;

  const ActivitiesOrderItem(this.order);

  @override
  List<Object?> get props => [order];
}

/// Owner states

sealed class ActivitiesOrderItem$Owner extends ActivitiesOrderItem {
  const ActivitiesOrderItem$Owner({required OrderModel order}) : super(order);
}

class ActivitiesOrderItem$Owner$Created extends ActivitiesOrderItem$Owner {
  final Money priceIncreaseAmount;

  const ActivitiesOrderItem$Owner$Created({required super.order, required this.priceIncreaseAmount});

  @override
  List<Object?> get props => [...super.props, priceIncreaseAmount];
}

class ActivitiesOrderItem$Owner$SelectCandidate extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$SelectCandidate({required super.order});
}

class ActivitiesOrderItem$Owner$Assigned extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$Assigned({required super.order});
}

class ActivitiesOrderItem$Owner$PickedUp extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$PickedUp({required super.order});
}

class ActivitiesOrderItem$Owner$Delivered extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$Delivered({required super.order});
}

class ActivitiesOrderItem$Owner$Completed extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$Completed({required super.order});
}

class ActivitiesOrderItem$Owner$Refunded extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$Refunded({required super.order});
}

class ActivitiesOrderItem$Owner$Expired extends ActivitiesOrderItem$Owner {
  const ActivitiesOrderItem$Owner$Expired({required super.order});
}

/// Worker states

sealed class ActivitiesOrderItem$Worker extends ActivitiesOrderItem {
  const ActivitiesOrderItem$Worker({required OrderModel order}) : super(order);
}

class ActivitiesOrderItem$Worker$Applied extends ActivitiesOrderItem$Worker {
  const ActivitiesOrderItem$Worker$Applied({required super.order});
}

class ActivitiesOrderItem$Worker$Assigned extends ActivitiesOrderItem$Worker {
  const ActivitiesOrderItem$Worker$Assigned({required super.order});
}

class ActivitiesOrderItem$Worker$PickedUp extends ActivitiesOrderItem$Worker {
  const ActivitiesOrderItem$Worker$PickedUp({required super.order});
}

class ActivitiesOrderItem$Worker$Delivered extends ActivitiesOrderItem$Worker {
  const ActivitiesOrderItem$Worker$Delivered({required super.order});
}

class ActivitiesOrderItem$Worker$Completed extends ActivitiesOrderItem$Worker {
  const ActivitiesOrderItem$Worker$Completed({required super.order});
}

class ActivitiesOrderItem$Worker$Refunded extends ActivitiesOrderItem$Worker {
  const ActivitiesOrderItem$Worker$Refunded({required super.order});
}
