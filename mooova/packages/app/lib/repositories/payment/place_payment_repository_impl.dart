import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:network_api/apis/order_management_api.dart';
import 'package:network_api/apis/payment_intent_api.dart';
import 'package:network_api/dtos/payment_intent_dto.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/date_time_mapper.dart';
import '../../models/mappers/payment_intent_mapper.dart';
import '../../models/payment_intent_model.dart';
import '../../models/types/payment_method_type.dart';
import '../../models/user_model.dart';
import '../exceptions/payment_exception.dart';
import '../user/user_repository.dart';
import 'place_payment_repository.dart';
import 'stripe_client_factory.dart';

class PlacePaymentRepositoryImpl implements PlacePaymentRepository {
  final StripeClientFactory stripeClientFactory;
  final PaymentIntentApi paymentIntentApi;
  final UserRepository userRepository;
  final OrderManagementApi orderManagementApi;

  PlacePaymentRepositoryImpl({
    required this.paymentIntentApi,
    required this.stripeClientFactory,
    required this.userRepository,
    required this.orderManagementApi,
  });

  @override
  Future<Result<PaymentIntentModel>> createIntent({
    required String orderId,
    required String workerId,
    required String? promoCode,
    required DateTime finalPickUpTime,
    required PaymentMethodType type,
  }) =>
      resultOf(() async {
        return userRepository
            .getUserId()
            .flatMapValue(
              (userId) => paymentIntentApi
                  .createIntent(
                    body: PaymentIntentCreateDto(
                      orderId: orderId,
                      userId: userId,
                      workerId: workerId,
                      finalPickupTime: finalPickUpTime.toDtoTimeInt(),
                      promoCode: promoCode,
                      paymentMethod: type.toDtoType(),
                    ),
                  )
                  .asHttpResponseResult(),
            )
            .mapValue((value) => value.toPaymentIntentModel(
                  orderId: orderId,
                  type: type,
                  finalPickUpTime: finalPickUpTime,
                  workerId: workerId,
                ));
      });

  @override
  Future<Result<void>> placeCardPayment({
    required PaymentIntentModel intent,
    required String number,
    required int expirationYear,
    required int expirationMonth,
    required String cvc,
    required bool save,
  }) =>
      resultOf(() async {
        final user = await userRepository.getUser();
        if (user is! ValueResult<UserModel>) {
          return user.asError!;
        }

        final client = await stripeClientFactory.create(publishableKey: intent.publishableKey);
        final params = stripe.PaymentMethodParams.card(
          paymentMethodData: stripe.PaymentMethodData(
            billingDetails: user.value.toBillingDetails(),
          ),
        );

        await client.dangerouslyUpdateCardDetails(stripe.CardDetails(
          number: number,
          cvc: cvc,
          expirationMonth: expirationMonth,
          expirationYear: expirationYear,
        ));

        await _performPayment(
          intent: intent,
          user: user.value,
          params: params,
        );

        try {
          if (save) {
            await client.createPaymentMethod(params: params);
          }
        } catch (ignore) {
          // We tried
        }

        return Result.value(null);
      });

  @override
  Future<Result<void>> placeKlarnaPayment({
    required PaymentIntentModel intent,
  }) =>
      resultOf(() async {
        final user = await userRepository.getUser();
        if (user is! ValueResult<UserModel>) {
          return user.asError!;
        }

        await _performPayment(
          intent: intent,
          user: user.value,
          params: stripe.PaymentMethodParams.klarna(
            paymentMethodData: stripe.PaymentMethodData(
              billingDetails: user.value.toBillingDetails(),
            ),
          ),
        );

        return Result.value(null);
      });

  @override
  Future<Result<void>> placeSavedCardPayment({
    required PaymentIntentModel intent,
    required String id,
  }) =>
      resultOf(() async {
        final user = await userRepository.getUser();
        if (user is! ValueResult<UserModel>) {
          return user.asError!;
        }

        await _performPayment(
          intent: intent,
          user: user.value,
          params: stripe.PaymentMethodParams.cardFromMethodId(
            paymentMethodData: stripe.PaymentMethodDataCardFromMethod(
              paymentMethodId: id,
              billingDetails: user.value.toBillingDetails(),
            ),
          ),
        );

        return Result.value(null);
      });

  Future<void> _performPayment({
    required PaymentIntentModel intent,
    required UserModel user,
    required stripe.PaymentMethodParams params,
  }) async {
    final client = await stripeClientFactory.create(publishableKey: intent.publishableKey);
    if (await client.isPaymentApproved(intent.clientSecret)) {
      await _setWorker(intent: intent);
      return;
    }

    final result = await client.confirmPayment(
      paymentIntentClientSecret: intent.clientSecret,
      data: params,
      options: const stripe.PaymentMethodOptions(
        setupFutureUsage: stripe.PaymentIntentsFutureUsage.OffSession,
      ),
    );

    if (result.status != stripe.PaymentIntentsStatus.Succeeded &&
        result.status != stripe.PaymentIntentsStatus.RequiresCapture) {
      throw PaymentIntentResultException(
        status: result.status,
        description: result.description,
        type: intent.type,
        orderId: intent.orderId,
      );
    }

    await _setWorker(intent: intent);
  }

  Future<void> _setWorker({
    required PaymentIntentModel intent,
  }) async {
    final result = await orderManagementApi
        .setOrderWorker(
          orderId: intent.orderId,
          workerId: intent.workerId,
          pickUpTime: intent.finalPickUpTime.toDtoTimeInt(),
        )
        .asHttpResponseResult();

    if (result is ErrorResult) {
      throw PaymentFailedToSetWorkerException(
        workerId: intent.workerId,
        description: result.error.toString(),
        orderId: intent.orderId,
      );
    }
  }
}

extension on UserModel {
  stripe.BillingDetails toBillingDetails() {
    return stripe.BillingDetails(
      email: email ?? 'email@here.com',
      name: displayName,
      phone: phone,
      address: stripe.Address(
        country: country.code,
        state: null,
        city: null,
        line1: null,
        line2: null,
        postalCode: null,
      ),
    );
  }
}
