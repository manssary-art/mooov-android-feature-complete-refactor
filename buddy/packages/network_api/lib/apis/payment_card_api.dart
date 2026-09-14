import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/payment_intent_dto.dart';
import '../dtos/payment_method_saved_dto.dart';

part 'payment_card_api.g.dart';

@RestApi()
abstract class PaymentCardApi {
  factory PaymentCardApi(
    Dio dio, {
    String? baseUrl,
  }) = _PaymentCardApi;

  @GET("/v1/payments/payment-methods")
  Future<HttpResponse<List<PaymentMethodSavedDto>>> getSavedCards();

  @GET("/v1/payments/payment-methods/{id}")
  Future<HttpResponse<void>> deleteSavedCard({
    @Path('id') required String id,
  });
}
