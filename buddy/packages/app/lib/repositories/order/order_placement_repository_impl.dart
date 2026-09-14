import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/apis/order_api.dart';
import 'package:network_api/apis/order_price_recommendation_api.dart';
import 'package:network_api/dtos/order_create_dto.dart';
import 'package:network_api/dtos/order_price_recommendation_dto.dart';
import 'package:network_api/dtos/order_update_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/date_time_mapper.dart';
import '../../models/mappers/order_mapper.dart';
import '../../models/mappers/order_price_recommendation.mapper.dart';
import '../../models/order_address_model.dart';
import '../../models/order_price_recommendation_model.dart';
import '../../models/types/order_size_type.dart';
import '../../models/types/order_type.dart';
import '../../models/types/product_condition_type.dart';
import '../user/user_repository.dart';
import 'order_placement_repository.dart';

class OrderPlacementRepositoryImpl implements OrderPlacementRepository {
  final UserRepository userRepository;
  final OrderPriceRecommendationApi orderPriceRecommendationApi;
  final OrderApi orderApi;

  OrderPlacementRepositoryImpl({
    required this.userRepository,
    required this.orderPriceRecommendationApi,
    required this.orderApi,
  });

  @override
  Future<Result<List<OrderPriceRecommendationModel>>> getPriceRecommendation({
    required OrderAddressModel pickUpAddress,
    required List<OrderAddressModel> deliveryAddresses,
  }) =>
      resultOf(() async {
        return await orderPriceRecommendationApi
            .getPriceRecommendation(
              body: OrderPriceRecommendationAddressDto(
                pickupAddress: pickUpAddress.toAddressDto(),
                deliveryAddresses: deliveryAddresses.map((e) => e.toAddressDto()).toList(),
              ),
            )
            .asHttpResponseResult()
            .mapValue((e) => e.recommendations.map((e) => e.toOrderPriceRecommendationModel()).toList());
      });

  @override
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
  }) =>
      resultOf(() async {
        return userRepository.getUserId().flatMapValue((userId) {
          final finalPriceValue = finalPrice?.takeIf((_) => orderType != OrderType.giveAway);
          final adminFeeValue = adminFee?.takeIf((_) => orderType != OrderType.giveAway);
          final currencyCodeValue = currency?.code.takeIf((_) => orderType != OrderType.giveAway);
          final productConditionValue = productCondition?.takeIf((_) => orderType == OrderType.giveAway);
          if (orderId != null) {
            return orderApi
                .updateOrder(
                  orderId: orderId,
                  body: OrderUpdateDto(
                    ownerId: userId,
                    orderId: orderId,
                    description: description,
                    finalPrice: finalPriceValue?.toDouble(),
                    adminFee: adminFeeValue?.toDouble(),
                    currencyCode: currencyCodeValue,
                    images: images,
                    deliveryAddresses: deliveryAddresses.map((e) => e.toAddressDto()).toList(),
                    pickupAddress: pickUpAddress.toAddressDto(),
                    numOfWorkersRequested: numOfWorkersRequested,
                    orderType: orderType.toDtoString(),
                    orderSize: orderSize.toDtoString(),
                    itemCondition: productConditionValue?.toDtoString(),
                    pickupTime: pickUpTimes.toDtoTimeInts(),
                  ),
                )
                .asHttpResponseResult();
          } else {
            return orderApi
                .createOrder(
                  body: OrderCreateDto(
                    ownerId: userId,
                    description: description,
                    finalPrice: finalPriceValue?.toDouble(),
                    adminFee: adminFeeValue?.toDouble(),
                    currencyCode: currencyCodeValue,
                    images: images,
                    deliveryAddresses: deliveryAddresses.map((e) => e.toAddressDto()).toList(),
                    pickupAddress: pickUpAddress.toAddressDto(),
                    numOfWorkersRequested: numOfWorkersRequested,
                    orderType: orderType.toDtoString(),
                    orderSize: orderSize.toDtoString(),
                    itemCondition: productConditionValue?.toDtoString(),
                    pickupTime: pickUpTimes.toDtoTimeInts(),
                  ),
                )
                .asHttpResponseResult();
          }
        });
      });
}
