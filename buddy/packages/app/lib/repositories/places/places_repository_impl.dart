import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/apis/places_api.dart';
import 'package:network_api/ext/http_response_ext.dart';

import '../../models/mappers/places_mapper.dart';
import '../../models/places_auto_complete_model.dart';
import '../../models/places_details_model.dart';
import 'places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final String googleCloudApiKey;
  final PlacesApi placesApi;

  PlacesRepositoryImpl({
    required this.googleCloudApiKey,
    required this.placesApi,
  });

  @override
  Future<Result<List<PlacesAutoCompleteModel>>> getPlacesAutoComplete({
    required String input,
    Country? country,
  }) =>
      resultOf(() async => await placesApi
          .getPlacesAutoComplete(apiKey: googleCloudApiKey, input: input)
          .asHttpResponseResult()
          .mapValue((e) => e.places?.mapNotNull((it) => it.toPlacesAutoCompleteModelOrNull()).toList() ?? []));

  @override
  Future<Result<PlacesDetailsModel>> getPlacesDetailsByPlaceId({
    required String placeId,
  }) =>
      resultOf(() async => await placesApi
          .getPlacesDetailsByPlaceId(apiKey: googleCloudApiKey, placeId: placeId)
          .asHttpResponseResult()
          .mapValue((e) => e.place?.toPlacesDetailsModelOrNull())
          .flatMapValue(
              (e) => e != null ? Result.value(e) : Result.error(Exception('toPlacesDetailsModelOrNull == null'))));

  @override
  Future<Result<PlacesDetailsModel>> getPlacesDetailsByCoordinates({
    required double lat,
    required double lng,
  }) =>
      resultOf(() async => await placesApi
          .getPlacesDetailsByCoordinates(apiKey: googleCloudApiKey, latlng: "$lat,$lng")
          .asHttpResponseResult()
          .mapValue((e) => e.place?.toPlacesDetailsModelOrNull())
          .flatMapValue(
              (e) => e != null ? Result.value(e) : Result.error(Exception('toPlacesDetailsModelOrNull == null'))));
}
