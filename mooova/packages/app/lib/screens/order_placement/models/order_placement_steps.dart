import '../../../../models/types/order_type.dart';

enum OrderPlacementStep {
  imagesMove,
  imagesGiveAway,
  inventory,
  address,
  price,
  review,
}

extension OrderTypeOrderPlacementDestinationsExt on OrderType {
  List<OrderPlacementStep> get asSteps {
    switch (this) {
      case OrderType.move:
        return [
          OrderPlacementStep.imagesMove,
          OrderPlacementStep.address,
          OrderPlacementStep.price,
          OrderPlacementStep.review,
        ];
      case OrderType.giveAway:
        return [
          OrderPlacementStep.imagesGiveAway,
          OrderPlacementStep.address,
          OrderPlacementStep.price,
          OrderPlacementStep.review,
        ];
      case OrderType.buyForMe:
      case OrderType.fetchForMe:
      case OrderType.recycle:
        return [
          OrderPlacementStep.inventory,
          OrderPlacementStep.address,
          OrderPlacementStep.price,
          OrderPlacementStep.review,
        ];
    }
  }
}
