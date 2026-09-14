import 'package:json_annotation/json_annotation.dart';

part 'user_referral_info_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UserReferralInfoDto {
  @JsonKey(name: 'referralCode')
  final String? referralCode;
  @JsonKey(name: 'referralLink')
  final String? referralLink;
  @JsonKey(name: 'referredBy')
  final String? referredBy;

  const UserReferralInfoDto({
    this.referralCode,
    this.referralLink,
    this.referredBy,
  });

  factory UserReferralInfoDto.fromJson(Map<String, dynamic> json) => _$UserReferralInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserReferralInfoDtoToJson(this);
}
