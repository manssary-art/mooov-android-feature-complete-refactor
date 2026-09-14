// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankInfoDto _$BankInfoDtoFromJson(Map<String, dynamic> json) => BankInfoDto(
      countryCode: json['country'] as String?,
      clearingNumber: json['clearingNumber'] as String?,
      accountNumber: json['accountNumber'] as String?,
      iban: json['iban'] as String?,
    );

Map<String, dynamic> _$BankInfoDtoToJson(BankInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('country', instance.countryCode);
  writeNotNull('clearingNumber', instance.clearingNumber);
  writeNotNull('accountNumber', instance.accountNumber);
  writeNotNull('iban', instance.iban);
  return val;
}
