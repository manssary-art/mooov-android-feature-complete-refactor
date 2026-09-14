import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/partner_store_dto.dart';

part 'partner_api.g.dart';

@RestApi()
abstract class PartnerApi {
  factory PartnerApi(
    Dio dio, {
    String? baseUrl,
  }) = _PartnerApi;

  @GET("/v1/partners/stores")
  Future<HttpResponse<PartnerStoresDto>> getPartnerStores();
}
