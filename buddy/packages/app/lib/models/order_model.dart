import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'order_address_model.dart';
import 'types/order_size_type.dart';
import 'types/order_state_type.dart';
import 'types/order_type.dart';
import 'types/product_condition_type.dart';
import 'user_model.dart';

class OrderModel with EquatableMixin {
  final String orderId;
  final UserModel owner;
  final UserModel? worker;
  final Map<UserModel, List<DateTime>>? candidates;
  final String? description;
  final Currency currency;
  final double? originalPrice;
  final double finalPrice;
  final double? adminFee;
  final List<String>? images;
  final List<String>? pickupImages;
  final List<String>? deliveredImages;
  final List<OrderAddressModel>? deliveryAddresses;
  final OrderAddressModel? pickupAddress;
  final DateTime? deliverTime;
  final DateTime? finalPickupTime;
  final List<DateTime>? pickupTime;
  final int? numOfWorkersRequested;
  final OrderState orderState;
  final OrderType orderType;
  final int? totalDistance;
  final double? estimatedPrice;
  final OrderSize orderSize;
  final ProductCondition productCondition;

  const OrderModel({
    required this.orderId,
    required this.owner,
    required this.worker,
    required this.candidates,
    required this.description,
    required this.currency,
    required this.originalPrice,
    required this.finalPrice,
    required this.adminFee,
    required this.images,
    required this.pickupImages,
    required this.deliveredImages,
    required this.deliveryAddresses,
    required this.pickupAddress,
    required this.deliverTime,
    required this.finalPickupTime,
    required this.pickupTime,
    required this.numOfWorkersRequested,
    required this.orderState,
    required this.orderType,
    required this.totalDistance,
    required this.estimatedPrice,
    required this.orderSize,
    required this.productCondition,
  });

  @override
  List<Object?> get props => [
        orderId,
        owner,
        worker,
        candidates,
        description,
        currency,
        originalPrice,
        finalPrice,
        adminFee,
        images,
        pickupImages,
        deliveredImages,
        deliveryAddresses,
        pickupAddress,
        deliverTime,
        finalPickupTime,
        pickupTime,
        numOfWorkersRequested,
        orderState,
        orderType,
        totalDistance,
        estimatedPrice,
        orderSize,
        productCondition,
      ];

  OrderModel copyWith({
    String Function()? orderId,
    UserModel Function()? owner,
    UserModel? Function()? worker,
    Map<UserModel, List<DateTime>>? Function()? candidates,
    String? Function()? description,
    Currency Function()? currency,
    double? Function()? originalPrice,
    double Function()? finalPrice,
    double? Function()? adminFee,
    List<String>? Function()? images,
    List<String>? Function()? pickupImages,
    List<String>? Function()? deliveredImages,
    List<OrderAddressModel>? Function()? deliveryAddresses,
    OrderAddressModel? Function()? pickupAddress,
    DateTime? Function()? deliverTime,
    DateTime? Function()? finalPickupTime,
    List<DateTime> Function()? pickupTime,
    int? Function()? numOfWorkersRequested,
    OrderState Function()? orderState,
    OrderType Function()? orderType,
    int? Function()? totalDistance,
    double? Function()? estimatedPrice,
    OrderSize Function()? orderSize,
    ProductCondition Function()? productCondition,
  }) {
    return OrderModel(
      orderId: orderId != null ? orderId() : this.orderId,
      owner: owner != null ? owner() : this.owner,
      worker: worker != null ? worker() : this.worker,
      candidates: candidates != null ? candidates() : this.candidates,
      description: description != null ? description() : this.description,
      currency: currency != null ? currency() : this.currency,
      originalPrice: originalPrice != null ? originalPrice() : this.originalPrice,
      finalPrice: finalPrice != null ? finalPrice() : this.finalPrice,
      adminFee: adminFee != null ? adminFee() : this.adminFee,
      images: images != null ? images() : this.images,
      pickupImages: pickupImages != null ? pickupImages() : this.pickupImages,
      deliveredImages: deliveredImages != null ? deliveredImages() : this.deliveredImages,
      deliveryAddresses: deliveryAddresses != null ? deliveryAddresses() : this.deliveryAddresses,
      pickupAddress: pickupAddress != null ? pickupAddress() : this.pickupAddress,
      deliverTime: deliverTime != null ? deliverTime() : this.deliverTime,
      finalPickupTime: finalPickupTime != null ? finalPickupTime() : this.finalPickupTime,
      pickupTime: pickupTime != null ? pickupTime() : this.pickupTime,
      numOfWorkersRequested: numOfWorkersRequested != null ? numOfWorkersRequested() : this.numOfWorkersRequested,
      orderState: orderState != null ? orderState() : this.orderState,
      orderType: orderType != null ? orderType() : this.orderType,
      totalDistance: totalDistance != null ? totalDistance() : this.totalDistance,
      estimatedPrice: estimatedPrice != null ? estimatedPrice() : this.estimatedPrice,
      orderSize: orderSize != null ? orderSize() : this.orderSize,
      productCondition: productCondition != null ? productCondition() : this.productCondition,
    );
  }
}
