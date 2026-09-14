import 'package:json_annotation/json_annotation.dart';

part 'user_business_info_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UserBusinessInfoDto {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'vatNumber')
  final String? vatNumber;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'hasTrafficPermit')
  final bool? hasTrafficPermit;

  const UserBusinessInfoDto({
    this.name,
    this.vatNumber,
    this.address,
    this.hasTrafficPermit,
  });

  factory UserBusinessInfoDto.fromJson(Map<String, dynamic> json) => _$UserBusinessInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserBusinessInfoDtoToJson(this);
}
