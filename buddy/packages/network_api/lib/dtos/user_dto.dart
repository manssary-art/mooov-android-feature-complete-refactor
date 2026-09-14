import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'geo_point_dto.dart';
import 'user_business_info_dto.dart';
import 'user_referral_info_dto.dart';
import 'user_settings_dto.dart';
import 'worker_vehicle_info_dto.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: 'id')
  final String userId;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'application')
  final String? application;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'rating')
  final double? rating;
  @JsonKey(name: 'cutRate')
  final double? cutRate;
  @JsonKey(name: 'orderCounter')
  final int? orderCounter;
  @JsonKey(name: 'orderDeliverCounter')
  final int? orderDeliverCounter;
  @JsonKey(name: 'addresses')
  final List<AddressDto>? addresses;
  @JsonKey(name: 'referral')
  final UserReferralInfoDto? referral;
  @JsonKey(name: 'fcmToken')
  final String? fcmToken;
  @JsonKey(name: 'businessInfo')
  final UserBusinessInfoDto? businessInfo;
  @JsonKey(name: 'business')
  final bool? business;
  @JsonKey(name: 'vehicles')
  final List<WorkerVehicleInfo>? vehicles;
  @JsonKey(name: 'geoPoint')
  final GeoPointDto? geoPoint;
  @JsonKey(name: 'level')
  final String? level;
  @JsonKey(name: 'tags')
  final List<String>? tags;
  @JsonKey(name: 'settings')
  final UserSettingsDto? settings;

  const UserDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
    required this.email,
    required this.role,
    required this.application,
    required this.country,
    required this.rating,
    required this.cutRate,
    required this.orderCounter,
    required this.orderDeliverCounter,
    required this.addresses,
    required this.referral,
    required this.fcmToken,
    required this.businessInfo,
    required this.business,
    required this.vehicles,
    required this.geoPoint,
    required this.level,
    required this.tags,
    required this.settings,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
