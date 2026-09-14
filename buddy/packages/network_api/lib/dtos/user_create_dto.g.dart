// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateDto _$UserCreateDtoFromJson(Map<String, dynamic> json) =>
    UserCreateDto(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      referral: json['referral'] == null
          ? null
          : UserReferralInfoDto.fromJson(
              json['referral'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCreateDtoToJson(UserCreateDto instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('phone', instance.phone);
  writeNotNull('email', instance.email);
  writeNotNull('country', instance.country);
  writeNotNull('referral', instance.referral);
  return val;
}
