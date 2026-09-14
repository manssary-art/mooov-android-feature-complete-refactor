import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/payment_intent_dto.dart';

part 'payment_intent_api.g.dart';

@RestApi()
abstract class PaymentIntentApi {
  factory PaymentIntentApi(
    Dio dio, {
    String? baseUrl,
  }) = _PaymentIntentApi;

  @POST("/v1/payments/create-payment-intent")
  Future<HttpResponse<PaymentIntentDto>> createIntent({
    @Body() required PaymentIntentCreateDto body,
  });
}
