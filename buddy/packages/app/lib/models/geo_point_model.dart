import 'package:equatable/equatable.dart';

class GeoPointModel with EquatableMixin {
  final double latitude;
  final double longitude;

  const GeoPointModel({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];

  GeoPointModel copyWith({
    double Function()? latitude,
    double Function()? longitude,
  }) {
    return GeoPointModel(
      latitude: latitude != null ? latitude() : this.latitude,
      longitude: longitude != null ? longitude() : this.longitude,
    );
  }
}
