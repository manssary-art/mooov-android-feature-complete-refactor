import 'package:equatable/equatable.dart';

class UserInfoWorkerModel with EquatableMixin {
  final double? rating;
  final double? cutRate;
  final int? orderDeliverCounter;
  final List<String>? vehiclesImagesUrls;
  final List<String>? tags;

  const UserInfoWorkerModel({
    required this.rating,
    required this.cutRate,
    required this.orderDeliverCounter,
    required this.vehiclesImagesUrls,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        rating,
        cutRate,
        orderDeliverCounter,
        vehiclesImagesUrls,
        tags,
      ];

  UserInfoWorkerModel copyWith({
    double? Function()? rating,
    double? Function()? cutRate,
    int? Function()? orderDeliverCounter,
    List<String>? Function()? vehiclesImagesUrls,
    List<String>? Function()? tags,
  }) {
    return UserInfoWorkerModel(
      rating: rating != null ? rating() : this.rating,
      cutRate: cutRate != null ? cutRate() : this.cutRate,
      orderDeliverCounter: orderDeliverCounter != null ? orderDeliverCounter() : this.orderDeliverCounter,
      vehiclesImagesUrls: vehiclesImagesUrls != null ? vehiclesImagesUrls() : this.vehiclesImagesUrls,
      tags: tags != null ? tags() : this.tags,
    );
  }
}
