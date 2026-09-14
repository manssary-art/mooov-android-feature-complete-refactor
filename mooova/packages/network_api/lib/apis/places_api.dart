import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/places_auto_complete_dto.dart';
import '../dtos/places_details_dto.dart';

part 'places_api.g.dart';

@RestApi(baseUrl: 'https://maps.googleapis.com')
abstract class PlacesApi {
  factory PlacesApi(
    Dio dio, {
    String? baseUrl,
  }) = _PlacesApi;

  @POST("/maps/api/place/autocomplete/json")
  Future<HttpResponse<PlacesAutoCompleteResponseDto>> getPlacesAutoComplete({
    @Query('key') required String apiKey,
    @Query('input') required String input,
    @Query('components') String? countriesQuery,
  });

  @POST("/maps/api/place/details/json")
  Future<HttpResponse<PlacesDetailsResponseDto>> getPlacesDetailsByPlaceId({
    @Query('key') required String apiKey,
    @Query('place_id') required String placeId,
  });

  @POST("/maps/api/geocode/json")
  Future<HttpResponse<PlacesDetailsResponseDto>> getPlacesDetailsByCoordinates({
    @Query('key') required String apiKey,
    @Query('latlng') required String latlng,
  });

  static String buildCountriesQuery({
    required List<String> countryCodes,
  }) =>
      countryCodes.where((e) => e.trim().isNotEmpty).map((e) => 'country:$e').join('|');
}
