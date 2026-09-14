import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'geo_point_dto.dart';
import 'user_business_info_dto.dart';
import 'user_referral_info_dto.dart';
import 'user_settings_dto.dart';
import 'worker_vehicle_info_dto.dart';

part 'user_update_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UserUpdateDto {
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

  const UserUpdateDto({
    required this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.image,
    this.email,
    this.role,
    this.application,
    this.country,
    this.rating,
    this.cutRate,
    this.orderCounter,
    this.orderDeliverCounter,
    this.addresses,
    this.referral,
    this.fcmToken,
    this.businessInfo,
    this.business,
    this.vehicles,
    this.geoPoint,
    this.level,
    this.tags,
    this.settings,
  });

  factory UserUpdateDto.fromJson(Map<String, dynamic> json) => _$UserUpdateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateDtoToJson(this);
}
