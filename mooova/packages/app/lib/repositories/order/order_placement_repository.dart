import 'package:async/async.dart';
import 'package:core/core.dart';

import '../../models/order_address_model.dart';
import '../../models/order_price_recommendation_model.dart';
import '../../models/types/order_size_type.dart';
import '../../models/types/order_type.dart';
import '../../models/types/product_condition_type.dart';

abstract interface class OrderPlacementRepository {
  Future<Result<List<OrderPriceRecommendationModel>>> getPriceRecommendation({
    required OrderAddressModel pickUpAddress,
    required List<OrderAddressModel> deliveryAddresses,
  });

  Future<Result<void>> createOrUpdateOrder({
    required String? orderId,
    required OrderType orderType,
    required OrderSize orderSize,
    required String description,
    required Money? finalPrice,
    required Money? adminFee,
    required Currency? currency,
    required List<String> images,
    required List<DateTime> pickUpTimes,
    required int numOfWorkersRequested,
    required ProductCondition? productCondition,
    required OrderAddressModel pickUpAddress,
    required List<OrderAddressModel> deliveryAddresses,
  });
}
