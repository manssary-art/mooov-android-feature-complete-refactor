// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
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

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'image': instance.image,
      'email': instance.email,
      'role': instance.role,
      'application': instance.application,
      'country': instance.country,
      'rating': instance.rating,
      'cutRate': instance.cutRate,
      'orderCounter': instance.orderCounter,
      'orderDeliverCounter': instance.orderDeliverCounter,
      'addresses': instance.addresses,
      'referral': instance.referral,
      'fcmToken': instance.fcmToken,
      'businessInfo': instance.businessInfo,
      'business': instance.business,
      'vehicles': instance.vehicles,
      'geoPoint': instance.geoPoint,
      'level': instance.level,
      'tags': instance.tags,
      'settings': instance.settings,
    };
