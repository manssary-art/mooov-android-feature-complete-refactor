// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_referral_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReferralInfoDto _$UserReferralInfoDtoFromJson(Map<String, dynamic> json) =>
    UserReferralInfoDto(
      referralCode: json['referralCode'] as String?,
      referralLink: json['referralLink'] as String?,
      referredBy: json['referredBy'] as String?,
    );

Map<String, dynamic> _$UserReferralInfoDtoToJson(UserReferralInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('referralCode', instance.referralCode);
  writeNotNull('referralLink', instance.referralLink);
  writeNotNull('referredBy', instance.referredBy);
  return val;
}
