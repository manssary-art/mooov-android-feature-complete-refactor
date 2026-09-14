import 'package:json_annotation/json_annotation.dart';

import 'user_referral_info_dto.dart';

part 'user_create_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UserCreateDto {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'country')
  final String? country;
  final UserReferralInfoDto? referral;

  const UserCreateDto(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.country,
      required this.referral});

  factory UserCreateDto.fromJson(Map<String, dynamic> json) => _$UserCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateDtoToJson(this);
}
