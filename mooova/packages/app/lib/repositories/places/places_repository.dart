import 'package:async/async.dart';
import 'package:core/core.dart';

import '../../models/places_auto_complete_model.dart';
import '../../models/places_details_model.dart';

abstract interface class PlacesRepository {
  Future<Result<List<PlacesAutoCompleteModel>>> getPlacesAutoComplete({
    required String input,
    Country? country,
  });

  Future<Result<PlacesDetailsModel>> getPlacesDetailsByPlaceId({
    required String placeId,
  });

  Future<Result<PlacesDetailsModel>> getPlacesDetailsByCoordinates({
    required double lat,
    required double lng,
  });
}
