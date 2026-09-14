import 'package:json_annotation/json_annotation.dart';

part 'places_auto_complete_dto.g.dart';

@JsonSerializable()
class PlacesAutoCompleteResponseDto {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'predictions')
  final List<PlacesAutoCompleteDto>? places;

  PlacesAutoCompleteResponseDto({this.status, this.places});

  factory PlacesAutoCompleteResponseDto.fromJson(Map<String, dynamic> json) => _$PlacesAutoCompleteResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesAutoCompleteResponseDtoToJson(this);
}

@JsonSerializable()
class PlacesAutoCompleteDto {
  /// [description] contains the human-readable name for the returned result. For establishment results, this is usually
  /// the business name.
  @JsonKey(name: 'description')
  final String? description;

  /// [distanceMeters] contains an integer indicating the straight-line distance between the predicted place,
  /// and the specified origin point, in meters. This field is only returned when the origin point is specified in the request.
  /// This field is not returned in predictions of type route.
  @JsonKey(name: 'distance_meters')
  final int? distanceMeters;

  /// [id] contains id.
  @JsonKey(name: 'id')
  final String? id;

  /// [placeId] is a textual identifier that uniquely identifies a place. To retrieve information about the place,
  /// pass this identifier in the placeId field of a Places API request. For more information about place IDs.
  @JsonKey(name: 'place_id')
  final String? placeId;

  /// [reference] contains reference.
  @JsonKey(name: 'reference')
  final String? reference;

  /// [structuredFormatting] provides pre-formatted text that can be shown in your autocomplete results
  @JsonKey(name: 'structured_formatting')
  final PlacesAutoCompleteDto$Structured? structuredFormatting;

  /// [types] contains an array of types that apply to this place. For example: [ "political", "locality" ] or
  /// [ "establishment", "geocode", "beauty_salon" ]. The array can contain multiple values.
  @JsonKey(name: 'types')
  final List<String>? types;

  PlacesAutoCompleteDto({
    this.description,
    this.distanceMeters,
    this.id,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.types,
  });

  factory PlacesAutoCompleteDto.fromJson(Map<String, dynamic> json) => _$PlacesAutoCompleteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesAutoCompleteDtoToJson(this);
}

@JsonSerializable()
class PlacesAutoCompleteDto$Structured {
  /// [mainText] contains the main text of a prediction, usually the name of the place.
  @JsonKey(name: 'main_text')
  final String? mainText;

  /// [secondaryText] contains the secondary text of a prediction, usually the location of the place.
  @JsonKey(name: 'secondary_text')
  final String? secondaryText;

  PlacesAutoCompleteDto$Structured({
    this.mainText,
    this.secondaryText,
  });

  factory PlacesAutoCompleteDto$Structured.fromJson(Map<String, dynamic> json) =>
      _$PlacesAutoCompleteDto$StructuredFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesAutoCompleteDto$StructuredToJson(this);
}
