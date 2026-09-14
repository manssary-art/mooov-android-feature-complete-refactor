// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateDto _$UserUpdateDtoFromJson(Map<String, dynamic> json) =>
    UserUpdateDto(
      userId: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      application: json['application'] as String?,
      country: json['country'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      cutRate: (json['cutRate'] as num?)?.toDouble(),
      orderCounter: json['orderCounter'] as int?,
      orderDeliverCounter: json['orderDeliverCounter'] as int?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      referral: json['referral'] == null
          ? null
          : UserReferralInfoDto.fromJson(
              json['referral'] as Map<String, dynamic>),
      fcmToken: json['fcmToken'] as String?,
      businessInfo: json['businessInfo'] == null
          ? null
          : UserBusinessInfoDto.fromJson(
              json['businessInfo'] as Map<String, dynamic>),
      business: json['business'] as bool?,
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => WorkerVehicleInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      geoPoint: json['geoPoint'] == null
          ? null
          : GeoPointDto.fromJson(json['geoPoint'] as Map<String, dynamic>),
      level: json['level'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      settings: json['settings'] == null
          ? null
          : UserSettingsDto.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserUpdateDtoToJson(UserUpdateDto instance) {
  final val = <String, dynamic>{
    'id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('phone', instance.phone);
  writeNotNull('image', instance.image);
  writeNotNull('email', instance.email);
  writeNotNull('role', instance.role);
  writeNotNull('application', instance.application);
  writeNotNull('country', instance.country);
  writeNotNull('rating', instance.rating);
  writeNotNull('cutRate', instance.cutRate);
  writeNotNull('orderCounter', instance.orderCounter);
  writeNotNull('orderDeliverCounter', instance.orderDeliverCounter);
  writeNotNull('addresses', instance.addresses);
  writeNotNull('referral', instance.referral);
  writeNotNull('fcmToken', instance.fcmToken);
  writeNotNull('businessInfo', instance.businessInfo);
  writeNotNull('business', instance.business);
  writeNotNull('vehicles', instance.vehicles);
  writeNotNull('geoPoint', instance.geoPoint);
  writeNotNull('level', instance.level);
  writeNotNull('tags', instance.tags);
  writeNotNull('settings', instance.settings);
  return val;
}
