import 'package:equatable/equatable.dart';

class PlacesAutoCompleteModel with EquatableMixin {
  final String description;
  final String placeId;
  final String? mainText;

  PlacesAutoCompleteModel({
    required this.description,
    required this.placeId,
    this.mainText,
  });

  @override
  List<Object?> get props => [
        description,
        placeId,
        mainText,
      ];
}
