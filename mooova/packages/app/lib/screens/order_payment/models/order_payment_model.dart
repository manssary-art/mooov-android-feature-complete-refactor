import 'package:equatable/equatable.dart';

import '../../../../models/order_model.dart';
import '../../../../models/user_model.dart';
import 'available_payment_methods.dart';

class OrderPaymentModel with EquatableMixin {
  final OrderModel order;
  final UserModel user;
  final List<AvailablePaymentMethod> methods;

  OrderPaymentModel({
    required this.user,
    required this.order,
    required this.methods,
  });

  @override
  List<Object?> get props => [
        user,
        order,
        methods,
      ];

  OrderPaymentModel copyWith({
    OrderModel Function()? order,
    UserModel Function()? user,
    List<AvailablePaymentMethod> Function()? methods,
  }) {
    return OrderPaymentModel(
      order: order != null ? order() : this.order,
      user: user != null ? user() : this.user,
      methods: methods != null ? methods() : this.methods,
    );
  }
}
