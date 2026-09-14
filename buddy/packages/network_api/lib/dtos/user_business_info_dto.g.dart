// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_business_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBusinessInfoDto _$UserBusinessInfoDtoFromJson(Map<String, dynamic> json) =>
    UserBusinessInfoDto(
      name: json['name'] as String?,
      vatNumber: json['vatNumber'] as String?,
      address: json['address'] as String?,
      hasTrafficPermit: json['hasTrafficPermit'] as bool?,
    );

Map<String, dynamic> _$UserBusinessInfoDtoToJson(UserBusinessInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('vatNumber', instance.vatNumber);
  writeNotNull('address', instance.address);
  writeNotNull('hasTrafficPermit', instance.hasTrafficPermit);
  return val;
}
